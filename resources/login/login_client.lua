    r_title = dxCreateFont( ":personajes/fonts/Roboto-BoldCondensed.ttf", 20 )
    r_text = dxCreateFont( ":personajes/fonts/Roboto-Regular.ttf",  11)
    r_desc = dxCreateFont( ":personajes/fonts/Roboto-Italic.ttf", 10 )
    r_button = dxCreateFont( ":personajes/fonts/Roboto-Condensed.ttf", 11 )

local screenWidth, screenHeight = guiGetScreenSize()

local page = "http://mta/local/index.html"
local initBrowser = guiCreateBrowser(0, 0, screenWidth, screenHeight, true, true, false)

local theBrowser = guiGetBrowser(initBrowser)

addEventHandler("onClientBrowserCreated", theBrowser, 
	function()
		loadBrowserURL(source, page)
		showCursor(true)
		guiSetInputEnabled ( true )

		addNotification("Inicia sesión con tu cuenta o registra una nueva", "info")
	--	loginsound = playSound ( "heartlands.mp3", true )
		guiSetInputEnabled ( true )
		guiSetInputEnabled ( true )
		guiSetInputEnabled ( true )
		toggleControl ("chatbox", false )-- y esta zona es para crear el browser ya que el PANEL está hecho con CEF que es basicamente HTML,CSS y JAvascript aplicado en MTA 
		-- el resto de paneles que haré no serán de este estilo
	end
)


function belepesfunkc(UsernameValue, PasswordValue)
username = tostring(UsernameValue)
password = tostring(PasswordValue)
--if loginsound then
--destroyElement(loginsound)
--end
triggerServerEvent("attemptLogin", localPlayer, localPlayer, username, password)

end

addEvent("belepesfunkc", true)
addEventHandler("belepesfunkc", root, belepesfunkc) -- el resto de cosas de este archivo, es para las notificaciones que saltan





function belepesfunkcregisztral(UsernameValue, PasswordValue, PasswordValue2, EmailC)
username = tostring(UsernameValue)
password = tostring(PasswordValue)
passwordc = tostring(PasswordValue2) 
email = tostring(EmailC) -- soy un puto genio

	if password ~= passwordc then
		addNotification("Las contraseñas no coinciden.", "warning")
	elseif #username < 4 then -- con #string leemos la longitud, por eso es innecesario lo otro
		addNotification("El nombre de usuario tiene que ser mínimo de 4 caracteres.", "warning")
	elseif #password < 4 then
		addNotification("La contraseña tiene que ser mínimo de 4 caracteres.", "warning")
	elseif #username > 35 then
		addNotification("El nombre de usuario no puede superar los 35 caracteres.", "warning")
	elseif #password > 35 then
		addNotification("La contraseña no puede ser mayor a 35 caracteres.", "warning")
	elseif #email < 4 then
		addNotification("El correo no puede ser inferior a 4 caracteres.", "warning")
	elseif string.find(email, "@") == nil then
		addNotification("El correo introducido no es válido, asegúrate de que lo escribes bien.", "warning") -- de todas formas ahora lo probaremos
	else
	triggerServerEvent("attemptRegister", localPlayer, localPlayer, username, password, email )
	end
end

addEvent("belepesfunkcregisztral", true)
addEventHandler("belepesfunkcregisztral", root, belepesfunkcregisztral)


function belepesfunkct()
destroyElement(initBrowser)
guiSetInputEnabled(false)
showCursor(false)
toggleControl ("chatbox", true )
end

addEvent("belepesfunkctsiker", true)
addEventHandler("belepesfunkctsiker", getLocalPlayer(), belepesfunkct)



local displayWidth, displayHeight = guiGetScreenSize();

local notificationData = {};

local notificationFont = dxCreateFont('files/fonts/roboto.ttf', 12 * 2, false);
local iconsFont = dxCreateFont('files/fonts/icons.ttf', 12 * 2, false);

addEventHandler('onClientRender', root,
	function()
		for k, v in pairs(notificationData) do
			if (v.State == 'fadeIn') then
				local alphaProgress = (getTickCount() - v.AlphaTick) / 650;
				local alphaAnimation = interpolateBetween(0, 0, 0, 255, 0, 0, alphaProgress, 'Linear');
				
				if (alphaAnimation) then
					v.Alpha = alphaAnimation;
				else
					v.Alpha = 255;
				end
				
				if (alphaProgress > 1) then
					v.Tick = getTickCount();
					v.State = 'openTile';
				end
			elseif (v.State == 'fadeOut') then
				local alphaProgress = (getTickCount() - v.AlphaTick) / 650;
				local alphaAnimation = interpolateBetween(255, 0, 0, 0, 0, 0, alphaProgress, 'Linear');
				
				if (alphaAnimation) then
					v.Alpha = alphaAnimation;
				else
					v.Alpha = 0;
				end
				
				if (alphaProgress > 1) then
					notificationData = {};
				end
			elseif (v.State == 'openTile') then
				local tileProgress = (getTickCount() - v.Tick) / 350;
				local tilePosition = interpolateBetween(v.StartX, 0, 0, v.EndX, 0, 0, tileProgress, 'Linear');
				local tileWidth = interpolateBetween(0, 0, 0, v.Width, 0, 0, tileProgress, 'Linear');
				
				if (tilePosition and tileWidth) then
					v.CurrentX = tilePosition;
					v.CurrentWidth = tileWidth;
				else
					v.CurrentX = v.EndX;
					v.CurrentWidth = v.Width;
				end
				
				if (tileProgress > 1) then
					v.State = 'fixTile';
					
					setTimer(function()
						v.Tick = getTickCount();
						v.State = 'closeTile';
					end, string.len(v.Text) * 45 + 5000, 1);
				end
			elseif (v.State == 'closeTile') then
				local tileProgress = (getTickCount() - v.Tick) / 350;
				local tilePosition = interpolateBetween(v.EndX, 0, 0, v.StartX, 0, 0, tileProgress, 'Linear');
				local tileWidth = interpolateBetween(v.Width, 0, 0, 0, 0, 0, tileProgress, 'Linear');
				
				if (tilePosition and tileWidth) then
					v.CurrentX = tilePosition;
					v.CurrentWidth = tileWidth;
				else
					v.CurrentX = v.StartX;
					v.CurrentWidth = 0;
				end
				
				if (tileProgress > 1) then
					v.AlphaTick = getTickCount();
					v.State = 'fadeOut';
				end
			elseif (v.State == 'fixTile') then
				v.Alpha = 255;
				v.CurrentX = v.EndX;
				v.CurrentWidth = v.Width;
			end
			
			roundedRectangle(v.CurrentX, 20, 25 + v.CurrentWidth, 25, tocolor(0, 0, 0, 150 * v.Alpha / 255), _, true);
			dxDrawRectangle(v.CurrentX, 20, 25, 25, tocolor(0, 0, 0, 255 * v.Alpha / 255), true);
			
			if (v.Alpha == 255) then
				dxDrawText(v.Text, v.CurrentX + 25 + 10, 20, v.CurrentX + 25 + 10 + v.CurrentWidth - 20, 20 + 25, tocolor(255, 255, 255, 255), 0.9, r_desc, 'center', 'center', true, false, true);
			end
			
			if (v.Type == 'error') then
				dxDrawText('', v.CurrentX + 5, 20, v.CurrentX + 5 + 25 - 10, 20 + 25, tocolor(200,5,5, v.Alpha), 0.50, iconsFont, 'center', 'center', false, false, true);
			elseif (v.Type == 'warning') then
				dxDrawText('', v.CurrentX + 5, 20, v.CurrentX + 5 + 25 - 10, 20 + 25, tocolor(255,178,82, v.Alpha), 0.50, iconsFont, 'center', 'center', false, false, true);
			elseif (v.Type == 'info') then
				dxDrawText('', v.CurrentX + 5, 20, v.CurrentX + 5 + 25 - 10, 20 + 25, tocolor(0,153,153, v.Alpha), 0.50, iconsFont, 'center', 'center', false, false, true);
			elseif (v.Type == 'success') then
				dxDrawText('', v.CurrentX + 5, 20, v.CurrentX + 5 + 25 - 10, 20 + 25, tocolor(0, 102, 51, v.Alpha), 0.50, iconsFont, 'center', 'center', false, false, true);
			end
		end
	end
)

addEvent('addNotification', true);
function addNotification(text, type)
	if (text and type) then
		if (notificationData ~= nil) then
			table.remove(notificationData, #notificationData);
		end
		
		table.insert(notificationData,
			{
				StartX = (displayWidth / 2) - (25 / 2),
				EndX = (displayWidth / 2) - ((dxGetTextWidth(text, 0.40, notificationFont) + 20 + 25) / 2),
				Text = text,
				Width = dxGetTextWidth(text, 0.40, notificationFont) + 20,
				Alpha = 0,
				State = 'fadeIn',
				Tick = 0,
				AlphaTick = getTickCount(),
				CurrentX = (displayWidth / 2) - (25 / 2),
				CurrentWidth = 0,
				Type = type or 'info'
			}
		);
		
		playSoundFrontEnd(11);
	end
end
addEventHandler('addNotification', root, addNotification);

function roundedRectangle(x, y, w, h, borderColor, bgColor, postGUI)
	if (x and y and w and h) then
		if (not borderColor) then
			borderColor = tocolor(0, 0, 0, 200);
		end
		
		if (not bgColor) then
			bgColor = borderColor;
		end
		
		--> Background
		dxDrawRectangle(x, y, w, h, bgColor, postGUI);
		
		--> Border
		dxDrawRectangle(x + 2, y - 1, w - 4, 1, borderColor, postGUI); -- top
		dxDrawRectangle(x + 2, y + h, w - 4, 1, borderColor, postGUI); -- bottom
		dxDrawRectangle(x - 1, y + 2, 1, h - 4, borderColor, postGUI); -- left
		dxDrawRectangle(x + w, y + 2, 1, h - 4, borderColor, postGUI); -- right
	end
end


