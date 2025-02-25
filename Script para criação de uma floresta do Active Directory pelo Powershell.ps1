﻿# Script para criação de uma floresta do Active Directory pelo Powershell - Créditos Gabriel Luiz - www.gabrielluiz.com #



# Instalação da função ADDS ( Active Directory Domain Services).


Install-WindowsFeature -Name AD-Domain-Services -IncludeManagementTools


<# 

Explicação do comando: Install-WindowsFeature -Name AD-Domain-Services - IncludeManagementTools


Install-WindowsFeature - Este comando permitirá instalar a função do Windows, os serviços de função ou o recurso do Windows no servidor local ou remoto. É semelhante ao uso do gerenciador de servidores do Windows para instalá-los.


-Name AD-Domain-Services - Nome da função a ser instalada, neste exemplo será o Active Directory Domain Services.


-IncludeManagementTools - Isso instalará as ferramentas de gerenciamento para o serviço de função selecionado.

#>


# Instala uma nova configuração de floresta do Active Directory.


Install-ADDSForest -CreateDnsDelegation:$false -DatabasePath "C:\Windows\NTDS" -DomainMode "WinThreshold" -DomainName "gabrielluiz.lan" -DomainNetbiosName "GABRIELlUIZ" -ForestMode "WinThreshold" -InstallDns:$true -LogPath "C:\Windows\NTDS" -NoRebootOnCompletion:$false -SysvolPath "C:\Windows\SYSVOL" -Force:$true



<# 

Explicação do comando: Install-ADDSForest -CreateDnsDelegation:$false -DatabasePath "C:\Windows\NTDS" -DomainMode "WinThreshold" -DomainName "gabrielluiz.lan" -DomainNetbiosName "GABRIELlUIZ" -ForestMode "WinThreshold" -InstallDns:$true -LogPath "C:\Windows\NTDS" -NoRebootOnCompletion:$false -SysvolPath "C:\Windows\SYSVOL" -Force:$true 


Install-ADDSForest - Este comando permitirá configurar uma nova floresta do Active Directory.


-CreateDnsDelegation - O uso desse parâmetro pode definir se a delegação DNS deve fazer referência ao DNS integrado ao Active Directory.


-DatabasePath "C:\Windows\NTDS" - Este parâmetro será usado para definir o caminho da pasta para armazenar o arquivo de banco de dados do Active Directory (Ntds.dit).


-DomainMode "WinThreshold" - Este parâmetro especificará o nível funcional do domínio do Active Directory. acima, usei o modo WinThreshold, que é o Windows Server 2016. O Windows Server 2022 não possui nível funcional de domínio separado.


-DomainName "gabrielluiz.lan" - Este parâmetro define o FQDN para o domínio do Active Directory.


-DomainNetbiosName "GABRIELlUIZ" - Isso define o nome NetBIOS para o domínio raiz da floresta.


-ForestMode "WinThreshold" - Este parâmetro especificará o nível funcional da floresta do Active Directory. acima, usei o modo WinThreshold, que é o Windows Server 2016. O Windows Server 2016 não possui nível funcional de floresta separada.


-InstallDns:$true - Este parâmetro especificará se a função DNS precisa ser instalada com o controlador de domínio do Active Directory. Para uma nova floresta, é requisito padrão defini-la como $true.


-LogPath "C:\Windows\NTDS" - O caminho do log pode ser usado para especificar o local para salvar os arquivos de log do domínio.


-NoRebootOnCompletion:$false - Por padrão, o sistema reiniciará o servidor após a configuração do controlador de domínio. usar este comando pode impedir a reinicialização automática do sistema.


-SysvolPath "C:\Windows\SYSVOL" - Isso é para definir o caminho da pasta SYSVOL. O local padrão para ele será C:\Windows.


-Force:$true - Por padrão, o sistema reiniciará o servidor após a configuração do controlador de domínio. usar este comando pode impedir a reinicialização automática do sistema.





#>



# Validação da nova floresta.


# Este comando verfica dos serviços devem estar em execução.


Get-Service adws,kdc,netlogon,dns


# Este comando listará todos os detalhes de configuração do controlador de domínio.


Get-ADDomainController


# Este comando listará os detalhes sobre o domínio do Active Directory.


Get-ADDomain gabrielluiz.lan


# Este comando listará os detalhes da floresta do Active Directory.


Get-ADForest gabrielluiz.lan


# Este comando mostrará se o controlador de domínio está compartilhando a pasta SYSVOL.


Get-smbshare SYSVOL


# Recurso de compatibilidade de aplicativo do Server Core sob demanda (FOD) (Opcional)


Add-WindowsCapability -Online -Name ServerCore.AppCompatibility~~~~0.0.1.0 # Instala o Recurso de compatibilidade de aplicativo do Server Core sob demanda (FOD) usando o Windows Update.


# Mais informações: https://github.com/gabrielluizbh/FOD-WS-2019


<#

Referências:


https://learn.microsoft.com/en-us/powershell/module/servermanager/install-windowsfeature?view=windowsserver2022-ps&WT.mc_id=5003815

https://learn.microsoft.com/en-us/powershell/module/addsdeployment/install-addsforest?view=windowsserver2022-ps&WT.mc_id=5003815

https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.management/get-service?view=powershell-7.2&WT.mc_id=5003815

https://learn.microsoft.com/en-us/powershell/module/activedirectory/get-addomaincontroller?view=windowsserver2022-ps&WT.mc_id=5003815

https://learn.microsoft.com/en-us/powershell/module/activedirectory/get-addomain?view=windowsserver2022-ps&WT.mc_id=5003815

https://learn.microsoft.com/en-us/powershell/module/activedirectory/get-adforest?view=windowsserver2022-ps&WT.mc_id=5003815

https://learn.microsoft.com/en-us/powershell/module/smbshare/get-smbshare?WT.mc_id=5003815

#>