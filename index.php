<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Gerador de cpf</title>
</head>
<body">
<h1 align="center">Gerador de CPF</h2>
    <div align="center"> CPF: <br></div>
    <?php
    $num = array();
    $num[9]=$num[10]=$num[11]=0;
    for ($w=0; $w > -2; $w--){
        for($i=$w; $i < 9; $i++){
            $x=($i-10)*-1;
            $w==0?$num[$i]=rand(0,9):'';
            echo ($w==0?$num[$i]:'');
            ($w==-1 && $i==$w && $num[11]==0)?
            $num[11]+=$num[10]*2    :
            $num[10-$w]+=$num[$i-$w]*$x;
        }
        $num[10-$w]=(($num[10-$w]%11)<2?0:(11-($num[10-$w]%11)));
        echo $num[10-$w];
    }
    echo '<div class="numero" align="center"><br>'.$num[0].$num[1].$num[2].'.'.$num[3].$num[4].$num[5].'.'.$num[6].$num[7].$num[8].'-'.$num[10].$num[11];
    // recebe o valor para inserir no arquivo .txt
    $p = $num[0].$num[1].$num[2].'.'.$num[3].$num[4].$num[5].'.'.$num[6].$num[7].$num[8].'-'.$num[10].$num[11];
    // Abre ou cria o arquivo cpf.txt
    // "a" representa que o arquivo é aberto para ser escrito
    $fp = fopen("cpf.txt", "a");

    // Escreve "exemplo de escrita" no cpf.txt
    $escreve = fwrite($fp, $p . "\r\n");

    // Fecha o arquivo
    fclose($fp); 

    $page = $_SERVER['PHP_SELF'];
    $sec = ".001";
    header("Refresh: $sec; url=$page");

    ?>
</body>
<style>
    body{
        background-color: #2e2e2e;
        color: #2e2e2e;
    }
    body h1{
        color: rgb(190, 191, 193);
        font-family: "Titillium",Arial,sans-serif;
        font-size: 50px;
    }
    div{
        color: rgb(190, 191, 193);
        font-size: 30px;
        font-family: "Titillium",Arial,sans-serif;
    }
    .numero{
        color: #ec1018;
        font-size: 100px;
        font-family: "Titillium",Arial,sans-serif;
    }

</style>
</html>