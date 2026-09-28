CREATE TABLE IF NOT EXISTS `robbery_data` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `player_id` INT NOT NULL,
    `last_robbery` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `successful_robberies` INT DEFAULT 0,
    `failed_robberies` INT DEFAULT 0
);

INSERT INTO `robbery_data` (`player_id`, `last_robbery`, `successful_robberies`, `failed_robberies`) VALUES
(1, NOW(), 0, 0);