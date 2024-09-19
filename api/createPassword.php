<?php
require_once("../connections/connect.php");

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $database = new Database();
    $body = json_decode(file_get_contents('php://input'), true);
    $correo = trim($body['email']);
    $pass = trim($body['contrasena']);
    $newPass = trim($body['nuevaContrasena']);
    $passConfirm = trim($body['confirmarContrasena']);

    if ($newPass != $passConfirm) {
        echo json_encode(['resp' => false, 'message' => '!Ups! La contraseña no coinciden']);
        exit;
    }

    $query = "SELECT * FROM Usuario WHERE correo = ?";
    $result = $database->consult($query, [$correo]);
    $passHash = $result["data"][0]["contrasena"];
    if (!password_verify($pass, $passHash)) {
        echo json_encode(['resp' => false, 'message' => '¡Ups! credenciales erradas']);
        exit;
    }

    $newPass = password_hash($newPass, PASSWORD_DEFAULT, ['cost' => 15]);
    $query = "UPDATE Usuario SET contrasena = ? WHERE correo = ?";
    $result = $database->execute($query, [$newPass, $correo]);

    if (!$result['resp']) {
        echo json_encode(['resp' => false, 'message' => '!Ups! Hubo un error al cambiar al contraseña']);
        exit;
    }

    echo json_encode(['resp' =>  true, 'message' => '¡Muy bien! Cambiaste la contraseña con exito']);
}
