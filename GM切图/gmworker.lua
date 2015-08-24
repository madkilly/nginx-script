local file_exists = function(name)
    local f=io.open(name,"r")
    if f~=nil then io.close(f) return true else return false end
end

local area = nil
local originalUri = ngx.var.uri;
local originalFile = ngx.var.file;
local originalDir = ngx.var.dir;
local index = string.find(ngx.var.uri, "([0-9]+)x([0-9]+)");  
--error(originalUri);
--error(originalFile);
if index then 
    originalUri = string.sub(ngx.var.uri, 0, index-2);  
  
    area = string.sub(ngx.var.uri, index);  
    index = string.find(area, "([.])");  
    area = string.sub(area, 0, index-1);  

    local index = string.find(originalFile, "([0-9]+)x([0-9]+)");  
    originalFile = string.sub(originalFile, 0, index-2);
    --error(originalFile);
    --error(area);

    --originalDir = ngx.var.dir;
    --lua_debug(originalDir);
end

if not file_exists(originalFile) then
    --local command = "wget -q -P " .. originalDir  .. " http://192.168.56.102:81" .. originalUri;
    --error(command);
    --os.execute(command);
end

local image_sizes = {"80x80", "100x100", "200x200", "60x60"};  
function table.contains(table, element)  
    for _, value in pairs(table) do  
        if value == element then
            return true  
        end  
    end  
    return false  
end 

if table.contains(image_sizes, area) then  
    local command = "gm convert " .. originalFile  .. " -thumbnail " .. area .. " -extent " .. area .. " " .. ngx.var.file;  
    os.execute(command);
	--ngx.say(originalFile);
	--ngx.say(ngx.var.file);
    --error(command);  
end

if file_exists(ngx.var.file) then
    --ngx.req.set_uri(ngx.var.uri, true);
    ngx.exec(ngx.var.uri)
else
    ngx.exit(404)
end

