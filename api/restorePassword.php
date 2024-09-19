<?php
require_once("../connections/connect.php");

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $database = new Database();
    $body = json_decode(file_get_contents('php://input'), true);
    $email = $body['correo'];

    $query = "SELECT * FROM Usuario WHERE correo = ?";
    $result = $database->consult($query, [$email]);
    if (!$result['resp']) {
        echo json_encode(['resp' => false, 'message' => 'usuario no encontrado']);
        exit;
    }
    $user = $result['data'][0];
    $newPass = password_hash($user['identificacion'], PASSWORD_DEFAULT, ['cost' => 15]);

    $query = "UPDATE Usuario SET contrasena = ? WHERE id = ?";
    $result = $database->execute($query, [$newPass,$user['id']]);
    if (!$result['resp']){
        echo json_encode(['resp' => false, 'message' => 'Hubo un error al restaurar la contraseña']);
        exit;
    }

    echo json_encode(['resp' => true, 'message' => 'Se restauro la contraseña con exito']);
}

?>