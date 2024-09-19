<?php
require_once("../connections/connect.php");

// var_dump(password_needs_rehash('1234567', PASSWORD_DEFAULT, ['cost' => 15]));
if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $database = new Database();
    $body = json_decode(file_get_contents('php://input'), true);
    $correo = $body['correo'];
    $pass = $body['pass'];

    $query = "SELECT * FROM Usuario WHERE correo = ?";
    $result = $database->consult($query, [$correo]);

    if (!$result['resp'] || empty($result['data'])) {
        echo json_encode(['resp' => false, 'message' => '¡Ups! credenciales erroneas']);
        exit;
    }

    $passHas = $result["data"][0]["contrasena"];
    if (!password_verify($pass, $passHas)) {
        echo json_encode(['resp' => false, 'message' => '¡Ups! credenciales erroneas']);
        exit;
    }

    $query = "SELECT id,nombre,correo,telefono,identificacion,programaPsi,tipoDocumento FROM Usuario WHERE correo = ?";
    $result = $database->consult($query, [$correo]);
    if (!$result['resp']) {
        echo json_encode(['resp' => false, 'message' => '¡Ups! Error al consultar la informacion del usuario']);
        exit;
    }
    $user = $result['data'][0];

    echo json_encode([
        'resp' => true,
        'message' => 'Logeado',
        'data' => $user
    ]);
}
