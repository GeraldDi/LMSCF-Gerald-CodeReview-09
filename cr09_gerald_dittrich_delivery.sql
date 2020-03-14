-- phpMyAdmin SQL Dump
-- version 5.0.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Erstellungszeit: 14. Mrz 2020 um 15:52
-- Server-Version: 10.4.11-MariaDB
-- PHP-Version: 7.4.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Datenbank: `cr09_gerald_dittrich_delivery`
--
CREATE DATABASE IF NOT EXISTS `cr09_gerald_dittrich_delivery` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `cr09_gerald_dittrich_delivery`;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `deliveryn`
--

CREATE TABLE `deliveryn` (
  `DeliveryID` int(11) NOT NULL,
  `Deliverydate` date DEFAULT NULL,
  `Deliverytime` time DEFAULT NULL,
  `fk_locempID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Daten für Tabelle `deliveryn`
--

INSERT INTO `deliveryn` (`DeliveryID`, `Deliverydate`, `Deliverytime`, `fk_locempID`) VALUES
(1, '2020-03-12', '12:00:00', 1),
(2, '2020-03-13', '16:00:00', 2),
(3, '2020-03-14', '08:00:00', 3),
(4, '2020-03-15', '11:00:00', 4),
(5, '2020-03-15', '18:00:00', 6);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `employee`
--

CREATE TABLE `employee` (
  `EmployeeID` int(11) NOT NULL,
  `Name` varchar(40) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Daten für Tabelle `employee`
--

INSERT INTO `employee` (`EmployeeID`, `Name`) VALUES
(1, 'Hannes Alaba'),
(2, 'Sandra Braun'),
(3, 'Josef Clown'),
(4, 'Markus Meier'),
(5, 'Michael Berger'),
(6, 'Josef Stark');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `location`
--

CREATE TABLE `location` (
  `LocationID` int(11) NOT NULL,
  `Address` varchar(40) DEFAULT NULL,
  `fk_Mailaddress` varchar(40) DEFAULT NULL,
  `fk_PackageID` int(11) DEFAULT NULL,
  `City` varchar(40) NOT NULL,
  `Depositetdate` date NOT NULL,
  `Depositettime` time NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Daten für Tabelle `location`
--

INSERT INTO `location` (`LocationID`, `Address`, `fk_Mailaddress`, `fk_PackageID`, `City`, `Depositetdate`, `Depositettime`) VALUES
(1, 'Pickupplace1', 'maxmustermann@gmail.at', 1, 'Wien', '2020-03-08', '10:00:00'),
(2, 'Pickupplace2', 'Sandrameier@gmail.at', 2, 'Wien', '2020-03-09', '15:00:00'),
(3, 'Pickupplace3', 'hannesschnell@gmail.com', 3, 'Salzburg', '2020-03-08', '20:00:00'),
(4, 'Pickupplace4', 'monamusterfrau@gmail.at', 4, 'Graz', '2020-03-10', '10:21:52'),
(6, 'Pickupplace6', 'hannesniedermeier@gmail.com', 6, 'Bregenz', '2020-03-11', '15:00:00');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `locemp`
--

CREATE TABLE `locemp` (
  `LocempID` int(11) NOT NULL,
  `fk_LocationID` int(11) DEFAULT NULL,
  `fk_EmployeeID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Daten für Tabelle `locemp`
--

INSERT INTO `locemp` (`LocempID`, `fk_LocationID`, `fk_EmployeeID`) VALUES
(1, 1, 1),
(2, 2, 1),
(3, 3, 2),
(4, 4, 2),
(6, 6, 3);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `mail`
--

CREATE TABLE `mail` (
  `Mailaddress` varchar(40) NOT NULL,
  `Locationaddress` varchar(40) DEFAULT NULL,
  `fk_SenderID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Daten für Tabelle `mail`
--

INSERT INTO `mail` (`Mailaddress`, `Locationaddress`, `fk_SenderID`) VALUES
('hannesniedermeier@gmail.com', 'Pickupplace6', 6),
('hannesschnell@gmail.com', 'Pickupplace3', 4),
('maxmustermann@gmail.at', 'Pickupplace1', 1),
('monamusterfrau@gmail.at', 'Pickupplace4', 5),
('Sandrameier@gmail.at', 'Pickupplace2', 2);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `package`
--

CREATE TABLE `package` (
  `PackageID` int(11) NOT NULL,
  `Size` varchar(40) DEFAULT NULL,
  `Targetaddress` varchar(40) DEFAULT NULL,
  `fk_SenderID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Daten für Tabelle `package`
--

INSERT INTO `package` (`PackageID`, `Size`, `Targetaddress`, `fk_SenderID`) VALUES
(1, 'small', 'Targetaddress1', 1),
(2, 'big', 'Targetaddress2', 2),
(3, 'small', 'Targetaddress3', 4),
(4, 'big', 'Targetaddress4', 5),
(6, 'extra large', 'Targetaddress10', 6);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `recipient`
--

CREATE TABLE `recipient` (
  `RecipientID` int(11) NOT NULL,
  `Address` varchar(40) DEFAULT NULL,
  `Name` varchar(40) DEFAULT NULL,
  `fk_DeliveryID` int(11) DEFAULT NULL,
  `fk_deliverynID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Daten für Tabelle `recipient`
--

INSERT INTO `recipient` (`RecipientID`, `Address`, `Name`, `fk_DeliveryID`, `fk_deliverynID`) VALUES
(1, 'Targetaddress1', 'Klaus Schwarz', 1, 1),
(2, 'Targetaddress2', 'Alex Rot', 2, 2),
(3, 'Targetaddress3', 'Andrea Gruen', 3, 3),
(4, 'Targetaddress4', 'Julius Meier', 4, 4),
(5, 'Targetaddress20', 'Ludwig Parker', 5, 5);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `sender`
--

CREATE TABLE `sender` (
  `SenderID` int(11) NOT NULL,
  `Address` varchar(40) DEFAULT NULL,
  `Name` varchar(40) DEFAULT NULL,
  `City` varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Daten für Tabelle `sender`
--

INSERT INTO `sender` (`SenderID`, `Address`, `Name`, `City`) VALUES
(1, 'Hauptstraße 124', 'Max Mustermann', 'Wien'),
(2, 'Nebenstraße 356', 'Sandra Meier', 'Wien'),
(4, 'Weinplatz 74', 'Hannes Schnell', 'Salzburg'),
(5, 'Hauptstraße 234', 'Mona Musterfrau', 'Wien'),
(6, 'Buchplatz 54', 'Hannes Niedermeier', 'Bregenz');

--
-- Indizes der exportierten Tabellen
--

--
-- Indizes für die Tabelle `deliveryn`
--
ALTER TABLE `deliveryn`
  ADD PRIMARY KEY (`DeliveryID`),
  ADD KEY `fk_locempID` (`fk_locempID`);

--
-- Indizes für die Tabelle `employee`
--
ALTER TABLE `employee`
  ADD PRIMARY KEY (`EmployeeID`);

--
-- Indizes für die Tabelle `location`
--
ALTER TABLE `location`
  ADD PRIMARY KEY (`LocationID`),
  ADD KEY `fk_Mailaddress` (`fk_Mailaddress`),
  ADD KEY `fk_PackageID` (`fk_PackageID`);

--
-- Indizes für die Tabelle `locemp`
--
ALTER TABLE `locemp`
  ADD PRIMARY KEY (`LocempID`),
  ADD KEY `fk_LocationID` (`fk_LocationID`),
  ADD KEY `fk_EmployeeID` (`fk_EmployeeID`);

--
-- Indizes für die Tabelle `mail`
--
ALTER TABLE `mail`
  ADD PRIMARY KEY (`Mailaddress`),
  ADD KEY `fk_SenderID` (`fk_SenderID`);

--
-- Indizes für die Tabelle `package`
--
ALTER TABLE `package`
  ADD PRIMARY KEY (`PackageID`),
  ADD KEY `fk_SenderID` (`fk_SenderID`);

--
-- Indizes für die Tabelle `recipient`
--
ALTER TABLE `recipient`
  ADD PRIMARY KEY (`RecipientID`),
  ADD KEY `fk_deliverynID` (`fk_deliverynID`) USING BTREE;

--
-- Indizes für die Tabelle `sender`
--
ALTER TABLE `sender`
  ADD PRIMARY KEY (`SenderID`);

--
-- AUTO_INCREMENT für exportierte Tabellen
--

--
-- AUTO_INCREMENT für Tabelle `deliveryn`
--
ALTER TABLE `deliveryn`
  MODIFY `DeliveryID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT für Tabelle `employee`
--
ALTER TABLE `employee`
  MODIFY `EmployeeID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT für Tabelle `location`
--
ALTER TABLE `location`
  MODIFY `LocationID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT für Tabelle `locemp`
--
ALTER TABLE `locemp`
  MODIFY `LocempID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT für Tabelle `package`
--
ALTER TABLE `package`
  MODIFY `PackageID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT für Tabelle `recipient`
--
ALTER TABLE `recipient`
  MODIFY `RecipientID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT für Tabelle `sender`
--
ALTER TABLE `sender`
  MODIFY `SenderID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Constraints der exportierten Tabellen
--

--
-- Constraints der Tabelle `deliveryn`
--
ALTER TABLE `deliveryn`
  ADD CONSTRAINT `deliveryn_ibfk_1` FOREIGN KEY (`fk_locempID`) REFERENCES `locemp` (`LocempID`);

--
-- Constraints der Tabelle `location`
--
ALTER TABLE `location`
  ADD CONSTRAINT `location_ibfk_1` FOREIGN KEY (`fk_Mailaddress`) REFERENCES `mail` (`Mailaddress`),
  ADD CONSTRAINT `location_ibfk_2` FOREIGN KEY (`fk_PackageID`) REFERENCES `package` (`PackageID`);

--
-- Constraints der Tabelle `locemp`
--
ALTER TABLE `locemp`
  ADD CONSTRAINT `locemp_ibfk_1` FOREIGN KEY (`fk_LocationID`) REFERENCES `location` (`LocationID`),
  ADD CONSTRAINT `locemp_ibfk_2` FOREIGN KEY (`fk_EmployeeID`) REFERENCES `employee` (`EmployeeID`);

--
-- Constraints der Tabelle `mail`
--
ALTER TABLE `mail`
  ADD CONSTRAINT `mail_ibfk_1` FOREIGN KEY (`fk_SenderID`) REFERENCES `sender` (`SenderID`);

--
-- Constraints der Tabelle `package`
--
ALTER TABLE `package`
  ADD CONSTRAINT `package_ibfk_1` FOREIGN KEY (`fk_SenderID`) REFERENCES `sender` (`SenderID`);

--
-- Constraints der Tabelle `recipient`
--
ALTER TABLE `recipient`
  ADD CONSTRAINT `recipient_ibfk_1` FOREIGN KEY (`fk_deliverynID`) REFERENCES `deliveryn` (`DeliveryID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
