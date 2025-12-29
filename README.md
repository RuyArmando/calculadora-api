## Instruções de Instalação
Instruções de instalação e solução de problemas na instalação do programa da Calculadora offline.

## Apresentação
A Calculadora offline está disponível para os sistemas operacionais Windows, macOS e Linux. 
Nesses sistemas, o contribuinte tem mais de uma opção de instalar ou executar a Calculadora. 
Para se utilizar a Calculadora offline, basta abrir um navegador e acessar o endereço http://localhost:8080/api (para acessar a API) ou http://localhost (para acessar o Portal).

## Instalação e Execução através do Java 21
Os usuários que possuem o Java 21 instalado podem executar o seguinte comando, no prompt:
```
java -jar calculadora.jar --spring.profiles.active=offline
```
O caminho do arquivo calculadora.jar deve ser especificado com precisão, a depender do sistema operacional (Windows, macOS ou Linux)
