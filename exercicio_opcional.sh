# BAIXAR PÁGINA ALURA PARA ARQUIVO
curl https://www.alura.com.br/sobre >> alura.txt

# Adicionando a data atual e um texto no fim do arquivo
cp alura.txt alura.txt.bkp
date +"%d/%m/%Y" >> alura.txt
echo "Educação e Inovação" | tee -a alura.txt

# Mostrando o número de cursos da Alura!
curl https://www.alura.com.br/api/cursos | jq length > numero-cursos-alura.txt

