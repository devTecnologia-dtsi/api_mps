<?php
header('Content-Type: application/json');
require_once(__DIR__ . '/variables.php');

class Database
{
    private static $instance = null;
    private $conn;

    private $servername = SERVERNAME;
    private $username = USER;
    private $password = PASS;
    private $database = DBNAME;

    // Constructor privado para evitar la creación de instancias
    function __construct()
    {
        // Create connection
        $this->conn = new mysqli($this->servername, $this->username, $this->password, $this->database);
        $this->conn->set_charset('utf8');

        // Check connection
        if ($this->conn->connect_error) {
            die("Connection failed: " . $this->conn->connect_error);
        }
    }

    // Método estático para obtener la instancia única de la clase
    private static function getInstance()
    {
        if (!self::$instance) {
            self::$instance = new Database();
        }
        return self::$instance;
    }

    // Método para ejecutar consultas SQL
    public function consult($sql, $params)
    {
        try {
            $response = [];
            $stmt = $this->conn->prepare($sql);
            if ($stmt === false) {
                throw new Exception("Error al conectarse a la base de datos");
            }

            // Bind parameters
            if (!empty($params)) {
                $types = ''; // Empty types string
                $values = []; // Array to store parameter values
                foreach ($params as $param) {
                    if (is_int($param)) {
                        $types .= 'i'; // Integer
                    } elseif (is_float($param)) {
                        $types .= 'd'; // Double
                    } elseif (is_string($param)) {
                        $types .= 's'; // String
                    } else {
                        $types .= 'b'; // Blob
                    }
                    $values[] = $param; // Add parameter value to array
                }
                $stmt->bind_param($types, ...$values); // Bind parameters
            }

            // Execute statement
            if (!$stmt->execute()) {
                throw new Exception("¡Ups! Hubo un error el ejecutar la consulta");
            }

            // Get result
            $result = $stmt->get_result();

            // Fetch data
            $data = [];
            while ($row = $result->fetch_assoc()) {
                $data[] = $row;
            }

            // Close statement
            $stmt->close();

            $response = ['resp' => true, 'data' => $data];
        } catch (\Exception $e) {
            $response = ['resp' => false, 'error' => $e->getMessage()];
        }
        return $response;
    }

    public function execute($sql, $params)
    {
        try {
            $response = [];
            $stmt = $this->conn->prepare($sql);
            if ($stmt === false) {
                throw new Exception("Error al conectarse a la base de datos");
            }

            // Bind parameters
            if (!empty($params)) {
                $types = ''; // Empty types string
                $values = []; // Array to store parameter values
                foreach ($params as $param) {
                    if (is_int($param)) {
                        $types .= 'i'; // Integer
                    } elseif (is_float($param)) {
                        $types .= 'd'; // Double
                    } elseif (is_string($param)) {
                        $types .= 's'; // String
                    } else {
                        $types .= 'b'; // Blob
                    }
                    $values[] = $param; // Add parameter value to array
                }
                $stmt->bind_param($types, ...$values); // Bind parameters
            }

            // Execute statement
            if (!$stmt->execute()) {
                throw new Exception("¡Ups! Hubo un error el ejecutar la consulta");
            }

            $response = ['resp' => true];
        } catch (\Exception $e) {
            $response = ['resp' => false, 'error' => $e->getMessage()];
        }
        return $response;
    }
}
