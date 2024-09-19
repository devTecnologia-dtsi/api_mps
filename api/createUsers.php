<?php
require_once("../connections/connect.php");

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $database = new Database();
    $body = json_decode(file_get_contents('php://input'), true);
    $userNotSynchronized = [];
    $arrTypePerson = ['PACIENTES' => 1, 'CUIDADORES' => 2, 'ACOPEL' => 3, 'UNIMINUTO' => 4, 'OTRO' => 5];
    $arrTypeDocument = ['CC' => 1, 'CE' => 2, 'TI' => 3, 'PAS' => 4, 'OT' => 5];

    foreach ($body as $key => $user) {

        $typePerson = $key;
        $idTypePerson = key_exists($typePerson, $arrTypePerson) ? $arrTypePerson[$typePerson] : 5;
        foreach ($user as $infoUser) {

            if ($infoUser['correo_electronico'] == 'No aplica' or empty($infoUser['numero_documento'])) {
                $userNotSynchronized[] = $infoUser['nombre_completo'];
            } else {
                $query = "SELECT COUNT(*) cantidad FROM Usuario WHERE correo = ?";
                $exeQuery = $database->consult($query, [$infoUser['correo_electronico']]);

                if ($exeQuery['resp'] and $exeQuery['data'][0]['cantidad'] == 0) {

                    $idTypeDocument = key_exists($infoUser['tipo_documento'], $arrTypeDocument) ? $arrTypeDocument[$infoUser['tipo_documento']] : 5;
                    $pass = password_hash($infoUser["numero_documento"], PASSWORD_DEFAULT, ['cost' => 15]);
                    $query = "INSERT INTO Usuario (nombre, correo, telefono, identificacion, contrasena, tipoDocumento, tipoPersona) VALUES (?,?,?,?,?,?,?)";
                    $result = $database->execute($query, [
                        $infoUser["nombre_completo"],
                        $infoUser["correo_electronico"],
                        empty($infoUser["numero_contacto"]) ? 0 : strval($infoUser["numero_contacto"]),
                        strval($infoUser["numero_documento"]),
                        $pass,
                        $idTypeDocument,
                        $idTypePerson
                    ]);
                    if (empty($result)) {
                        $userNotSynchronized[] = $infoUser['nombre_completo'];
                    }
                }
            }
        }
    }
    echo json_encode(['proceso' => 'Finalizado', 'Usuario no sincronizados' => $userNotSynchronized]);
}
