# PayDay_project
Esse aplicativo foi desenvolvido com o objetivo de auxiliar o usuário com a organização de boletos, salvando os códigos do boleto e emitindo notificações de lembretes quando próximos a vencer. Por enquanto o aplicativo só está disponível para sistemas Android, mas futuramente estarei levando ele para o iOS, assim como acrescentando algumas melhorias também.

## Página de Login
Para usar o aplicativo basta o usuário se conectar com sua conta Google.

![Screenshot_1637247737](https://user-images.githubusercontent.com/49878384/142449806-ca1102ed-abdb-438a-8555-32e0fe1e2c95.png)

## Tela do Usuário

![Screenshot_1637249504](https://user-images.githubusercontent.com/49878384/142454841-9cf3c172-b13a-4f7f-8d45-d5543ac9a41f.png)

A imagem acima exibe a tela de gestão de boletos do usuário. Na parte inferior da tela temos três botões, sendo dois para navegação, entre as páginas ![home](https://user-images.githubusercontent.com/49878384/142477384-e7cf5670-79eb-416f-9350-fb31e44af804.png)
 **Home** e ![extract](https://user-images.githubusercontent.com/49878384/142477932-c8d94b83-6cf7-4546-9c35-336e9653606f.png) **Meus extratos**, e um para adicionar um boleto representado pelo ícone ![addBill](https://user-images.githubusercontent.com/49878384/142479032-c318fce8-d861-4610-aa01-8b1270e4baec.png). Veja a seguir mais detalhes sobre cada uma delas.

### Home
É a tela principal do usuário, nela teremos algumas informações úteis como:
- Lista de aplicativos de bancos
  
  Aqui é mostrado os ícones de todos os seus aplicativos bancários instalados em seu dispositivo, sendo possível abrir o aplicativo do banco apenas clicando no ícone. 
  
  _Obs: como os prints foram tirados do AVD (Android Virtual Device), a lista de bancos encontrasse vazia_
  
  ![bankList](https://user-images.githubusercontent.com/49878384/142453444-1fdd179c-d75a-4ab2-a13c-c97757b8e2eb.png)

- Lista de boletos que ainda não foram pagos
  
  Cada item da lista exibe as informações(data de vencimento, nome e valor) de seus respectivos boletos cadastrados. Quando a data de vencimento do boleto expirar o item na       lista ficará vermelho. No lado direito de cada item terá o botão de copiar para a área de transferência de seu dispositivo o código do boleto, podendo assim abrir o aplicativo   do seu banco na lista de bancos do Pay Day e pagar o boleto.
  
  ![billsList](https://user-images.githubusercontent.com/49878384/142464843-0b59a8df-7e5c-4fcf-b764-5ba573221672.png)
  
  O usuário tem a possibilidade de excluir o boleto cadastrado ou definir ele como um boleto que já foi pago, basta ele clicar no item do boleto de sua escolha que irá aparecer 
  as opções como mostra a imagem abaixo.
  
  ![Screenshot_1637249518](https://user-images.githubusercontent.com/49878384/142482210-2d421dfe-d205-4f4a-896e-cad61c9a700c.png)

### Meus extratos 
Aqui exibirá uma lista contendo todos os boletos que o usuário definiu como pago.

![Screenshot_1637249547](https://user-images.githubusercontent.com/49878384/142483403-10588f81-86d4-45e3-83fa-abb307d837d5.png)

### Adicionar boleto
O aplicativo disponibiliza duas opções para o usuário adicionar um boleto, sendo elas escaneando o código de barras com a câmera do celular e inserir as informações manualmente. Caso escolha a opção de escanear código de barra, após escaneamento o aplicativo redireciona o usuário para a tela **Preencha os dados do boleto** com alguns campos já preenchidos.

![Screenshot_1637258264](https://user-images.githubusercontent.com/49878384/142486797-56f95575-c62f-49cb-8916-7b1e15499d86.png)  ![Screenshot_1637249293](https://user-images.githubusercontent.com/49878384/142487845-14d1b130-c0b5-42ee-8d68-c10a325c6ece.png)

### Perfil do Usuário
Para que o usuário acesse seu perfil basta ele clicar na sua imagem no canto superior direito. Nela ele encontrará opções como:
  - Alterar o tema do aplicativo (Dark mode/Light mode)
  - Sair do aplicativo (deslogando a conta do aplicativo, possibilitando logar com outras contas)
  - Deletar conta (excluindo a conta e todo seu conteúdo cadastrado do banco de dados)

![Screenshot_1637249556](https://user-images.githubusercontent.com/49878384/142491981-c3274d56-2f04-477b-bc06-615c541416d3.png)  ![Screenshot_1637249565](https://user-images.githubusercontent.com/49878384/142491991-1a47d875-3bd3-4ca1-865d-64dc6bb0ea4f.png)

