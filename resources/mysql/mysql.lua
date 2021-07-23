connection = dbConnect( "mysql", "dbname=NombreDB;host=127.0.0.1", "usuario", "contraseña", "share=0" )

function connect()
	return connection
end

addEventHandler('onResourceStop', resourceRoot,
    function ()
        if (isElement(connection)) then
            destroyElement(connection)
        end
    end
)

