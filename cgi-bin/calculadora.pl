#!/usr/bin/perl
use strict;
use warnings;
use CGI;
use CGI::Carp qw(fatalsToBrowser);

my $q = CGI->new;

print $q->header(-type => "text/html", -charset => "UTF-8");

# Recuperar los valores del formulario
my $numero1 = $q->param('numero1') || 0;
my $operador = $q->param('operador') || '';
my $numero2 = $q->param('numero2') || 0;
my $resultado = '';

# Validación y cálculo basado en el operador seleccionado
if ($operador eq '+') {
    $resultado = $numero1 + $numero2;
} elsif ($operador eq '-') {
    $resultado = $numero1 - $numero2;
} elsif ($operador eq '*') {
    $resultado = $numero1 * $numero2;
} elsif ($operador eq '/') {
    if ($numero2 != 0) {
        $resultado = $numero1 / $numero2;
    } else {
        $resultado = "Error: División por cero no permitida.";
    }
} else {
    $resultado = "Error: Operador no válido.";
}

# Generar la respuesta HTML
print <<HTML;
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Calculadora Aritmética</title>
    <link rel="stylesheet" href="/css/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Akaya+Kanadaka&display=swap" rel="stylesheet">
</head>
<body>
    <h1>Calculadora con Perl</h1>

    <!-- Formulario para el cálculo -->
    <form action="/cgi-bin/calculadora.pl" method="post">
        <label for="numero1">Ingrese el primer número:</label>
        <input type="number" id="numero1" name="numero1" value="$numero1" required>
        <br><br>

        <!-- Botones para seleccionar el operador -->
        <div id="operadores">
            <button type="submit" name="operador" value="+">+</button>
            <button type="submit" name="operador" value="-">-</button>
            <button type="submit" name="operador" value="*">*</button>
            <button type="submit" name="operador" value="/">/</button>
        </div>
        <br><br>

        <label for="numero2">Ingrese el segundo número:</label>
        <input type="number" id="numero2" name="numero2" value="$numero2" required>
        <br><br>

        <button type="submit" name="calcular">Calcular</button>
    </form>

    <!-- Mostrar el resultado debajo del formulario -->
    <div id="resultado">
HTML

if ($resultado ne '') {
    print "El resultado de $numero1 $operador $numero2 es: $resultado";
}

print <<HTML;
    </div>

    <!-- Botón para regresar a la página principal -->
    <form action="/index.html" method="get" id="boton-regresar">
        <button type="submit">Regresar</button>
    </form>
</body>
</html>
HTML
