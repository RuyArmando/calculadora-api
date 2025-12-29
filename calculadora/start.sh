JAVA_HOME=/opt/java/openjdk
export JAVA_HOME
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
PATH=${JAVA_HOME}/bin:${PATH}
export PATH

clear

echo ""
echo "------------------------------------------------------------------"
echo "Calculadora de Tributos"
echo "------------------------------------------------------------------"
echo ""

profile="offline"

echo "------------------------------------------------------------------"
echo "Usando o perfil: $profile"
echo ""
echo "Em até 60 segundos os serviços estarão disponíveis."
echo "Aguarde o teste de disponibilidade dos serviços..."
echo "------------------------------------------------------------------"

mkdir -p /run/nginx
chown nginx:nginx /run/nginx

nginx > /dev/null 2>&1

echo "A interface gráfica já está disponível..."

echo ""

echo "Aguarde o teste de disponibilidade dos serviços..."

java -jar /calculadora/api-regime-geral.jar --spring.profiles.active=$profile > /dev/null 2>&1 &

java -jar /calculadora/api-split-payment-simplificado.jar --spring.profiles.active=local > /dev/null 2>&1 &

echo ""
echo "Aguardando as APIs inicializarem..."
echo ""
echo "Testando http://localhost:9101/health e http://localhost:9102/health"

while true; do
  health1=$(curl -s http://localhost:9101/health 2>/dev/null)
  health2=$(curl -s http://localhost:9102/health 2>/dev/null)
  
  if [[ "$health1" == *"UP"* && "$health2" == *"UP"* ]]; then
    clear
    echo "------------------------------------------------------------------"
    echo "Calculadora de Tributos"
    echo "------------------------------------------------------------------"
    echo ""
    echo "✓ Ambas as APIs estão funcionando!"
    echo ""
    echo "------------------------------------------------------------------"
    echo "Serviços disponíveis:"
    echo ""
    echo "http://localhost:80 para a interface gráfica"
    echo "http://localhost:8080/api para a API do Regime Geral"
    echo "http://localhost:8081/api para a API do Split Payment Simplificado"
    echo "------------------------------------------------------------------"
    break
  else
    echo -n "."
    sleep 2
  fi
done

echo ""
echo "Control-C para sair."

while true; do
  sleep 1
done