require("config.lazy")

-- Optionally pull in machine-local overrides from lua/local.lua (untracked).
-- pcall swallows the "module not found" error on machines without the file, so
-- the shared config stays portable. Loaded last, so it wins.
pcall(require, "local")
