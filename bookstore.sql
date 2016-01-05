-- phpMyAdmin SQL Dump
-- version 3.5.2.2
-- http://www.phpmyadmin.net
--
-- Gazda: 127.0.0.1
-- Timp de generare: 15 Ian 2013 la 13:01
-- Versiune server: 5.5.27
-- Versiune PHP: 5.4.7

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Baza de date: `bookstore`
--

-- --------------------------------------------------------

--
-- Structura de tabel pentru tabelul `address`
--

CREATE TABLE IF NOT EXISTS `address` (
  `addressID` int(50) NOT NULL AUTO_INCREMENT,
  `street` varchar(50) NOT NULL,
  `nr` int(50) NOT NULL,
  `city` varchar(50) NOT NULL,
  `country` varchar(50) NOT NULL,
  `postalCode` int(7) NOT NULL,
  PRIMARY KEY (`addressID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Salvarea datelor din tabel `address`
--

INSERT INTO `address` (`addressID`, `street`, `nr`, `city`, `country`, `postalCode`) VALUES
(1, 'Test street', 11, 'Craiova', 'Romania', 111111);

-- --------------------------------------------------------

--
-- Structura de tabel pentru tabelul `admin`
--

CREATE TABLE IF NOT EXISTS `admin` (
  `adminID` int(50) NOT NULL AUTO_INCREMENT,
  `email` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `firstName` varchar(50) NOT NULL,
  `lastName` varchar(50) NOT NULL,
  PRIMARY KEY (`adminID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Salvarea datelor din tabel `admin`
--

INSERT INTO `admin` (`adminID`, `email`, `password`, `firstName`, `lastName`) VALUES
(1, 'admin@test.com', 'admin', 'admin', 'admin');

-- --------------------------------------------------------

--
-- Structura de tabel pentru tabelul `customer`
--

CREATE TABLE IF NOT EXISTS `customer` (
  `customerID` int(50) NOT NULL AUTO_INCREMENT,
  `password` varchar(50) NOT NULL,
  `firstName` varchar(50) NOT NULL,
  `lastName` varchar(50) NOT NULL,
  `phone` varchar(11) NOT NULL,
  `email` varchar(50) NOT NULL,
  `shippingAddressID` int(50) DEFAULT NULL,
  `billingAddressID` int(50) DEFAULT NULL,
  PRIMARY KEY (`customerID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Salvarea datelor din tabel `customer`
--

INSERT INTO `customer` (`customerID`, `password`, `firstName`, `lastName`, `phone`, `email`, `shippingAddressID`, `billingAddressID`) VALUES
(1, 'pass', 'Test', 'User', '1111111111', 'user@test.com', 1, 1),
(2, 'customer2', 'customer2 ', 'customer2 ', '1111111112', 'customer2@test.com', NULL, NULL),
(3, 'eee', 'eee', 'eee', '1234', 'eee@e.com', NULL, NULL);

-- --------------------------------------------------------

--
-- Structura de tabel pentru tabelul `item`
--

CREATE TABLE IF NOT EXISTS `item` (
  `title` varchar(50) NOT NULL,
  `author` varchar(50) NOT NULL,
  `volume` varchar(10) NOT NULL,
  `publisher` varchar(50) NOT NULL,
  `yearPublished` int(4) NOT NULL,
  `ISBN` varchar(50) NOT NULL,
  `price` int(100) NOT NULL,
  `quantity` int(11) NOT NULL,
  PRIMARY KEY (`ISBN`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Salvarea datelor din tabel `item`
--

INSERT INTO `item` (`title`, `author`, `volume`, `publisher`, `yearPublished`, `ISBN`, `price`, `quantity`) VALUES
('Huliganii', 'Mircea Eliade', 'I', 'Humanitas', 2006, '1', 2, 20),
('Maitreyi', 'Mircea Eliade', 'I', 'Cartex', 2012, '2', 6, 367),
('Quo Vadis', 'Henryk Sienkiewicz', 'I', 'Gramar', 2009, '3', 5, 250),
('Morometii', 'Marin Preda', 'II', 'Curtea Veche', 2009, '4', 10, 998),
('Carrie', 'Stephen King', 'I', 'Nemira', 2011, '5', 10, 320),
('Cel mai iubit dintre pamanteni', 'Marin Preda', 'III', 'Cortex', 2010, '6', 15, 401);

-- --------------------------------------------------------

--
-- Structura de tabel pentru tabelul `order`
--

CREATE TABLE IF NOT EXISTS `order` (
  `orderID` int(50) NOT NULL AUTO_INCREMENT,
  `customerID` int(50) DEFAULT NULL,
  `orderDate` date DEFAULT NULL,
  `totalPrice` int(50) DEFAULT NULL,
  `status` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`orderID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Salvarea datelor din tabel `order`
--

INSERT INTO `order` (`orderID`, `customerID`, `orderDate`, `totalPrice`, `status`) VALUES
(1, 1, '2012-12-11', 40, 'new'),
(2, 1, '2013-01-11', 5, 'new'),
(3, 3, '2013-01-14', 44, 'new');

-- --------------------------------------------------------

--
-- Structura de tabel pentru tabelul `order_item`
--

CREATE TABLE IF NOT EXISTS `order_item` (
  `orderID` int(100) NOT NULL,
  `itemISBN` varchar(50) NOT NULL,
  `quantity` int(50) NOT NULL,
  PRIMARY KEY (`orderID`,`itemISBN`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Salvarea datelor din tabel `order_item`
--

INSERT INTO `order_item` (`orderID`, `itemISBN`, `quantity`) VALUES
(1, '2', 1),
(1, '3', 2),
(2, '1', 1),
(3, '2', 4),
(3, '4', 2);

-- --------------------------------------------------------

--
-- Structura de tabel pentru tabelul `shoppingcart`
--

CREATE TABLE IF NOT EXISTS `shoppingcart` (
  `customerID` int(100) NOT NULL,
  `itemISBN` varchar(50) NOT NULL,
  `quantity` int(50) NOT NULL,
  PRIMARY KEY (`customerID`,`itemISBN`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Salvarea datelor din tabel `shoppingcart`
--

INSERT INTO `shoppingcart` (`customerID`, `itemISBN`, `quantity`) VALUES
(1, '1', 1);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
