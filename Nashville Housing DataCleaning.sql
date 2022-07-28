SELECT *
FROM DataCleaning


--Standardize Date format

SELECT SaleDate, CONVERT(Date,SaleDate)
FROM DataCleaning

UPDATE DataCleaning
SET SaleDate = CONVERT(Date,SaleDate)

--Populate Property Address

SELECT *
FROM DataCleaning
--WHERE propertyAddress IS NULL
ORDER BY ParcelID

SELECT a.uniqueID,b.uniqueID,a.propertyAddress,b.propertyAddress, ISNULL(a.propertyAddress,b.propertyAddress)
FROM DataCleaning a
JOIN DataCleaning b
ON a.parcelID = b.parcelID
AND a.UniqueID <> b.UniqueID
WHERE a.propertyAddress IS NULL

UPDATE a
SET propertyAddress = ISNULL(a.propertyAddress,b.propertyAddress)
FROM DataCleaning a
JOIN DataCleaning b
ON a.parcelID = b.parcelID
AND a.UniqueID <> b.UniqueID
WHERE a.propertyAddress IS NULL

--Bringing out address into (address,city and state)
SELECT *
FROM DataCleaning

SELECT SUBSTRING(propertyAddress,1,CHARINDEX(',',propertyAddress)-1)
FROM DataCleaning

ALTER TABLE DataCleaning
ADD propertysplitAddress Nvarchar(255)

UPDATE DataCleaning
SET  propertysplitAddress = SUBSTRING(propertyAddress,1,CHARINDEX(',',propertyAddress)-1)

ALTER TABLE DataCleaning
ADD propertysplitCity Nvarchar(255)

UPDATE DataCleaning
SET  propertysplitCity = SUBSTRING(propertyAddress,CHARINDEX(',',propertyAddress)+1,LEN(propertyAddress))


--Bringing out address into (address,city and state) in another way 

SELECT PARSENAME(REPLACE(OwnerAddress,',','.'), 3),
PARSENAME(REPLACE(OwnerAddress,',','.'), 2),
PARSENAME(REPLACE(OwnerAddress,',','.'), 1)
FROM DataCleaning


ALTER TABLE DataCleaning
ADD propertysplitAdress Nvarchar(255)

UPDATE DataCleaning
SET  propertysplitAdress = PARSENAME(REPLACE(OwnerAddress,',','.'), 3)

ALTER TABLE DataCleaning
ADD propertysplitCityy Nvarchar(255)

UPDATE DataCleaning
SET  propertysplitcityy = PARSENAME(REPLACE(OwnerAddress,',','.'), 2)


ALTER TABLE DataCleaning
ADD propertysplitAddres Nvarchar(255)

UPDATE DataCleaning
SET  propertysplitAddres = PARSENAME(REPLACE(OwnerAddress,',','.'), 1)

--Changing Y and S to YES & NO IN SoldAsVacant column


SELECT SoldAsVacant,
CASE WHEN SoldAsVacant = 'Y' THEN 'YES'
WHEN SoldAsVacant = 'S'THEN 'NO'
ELSE SoldAsVacant
END
FROM DataCleaning

UPDATE DataCleaning
SET  propertysplitAddres = CASE WHEN SoldAsVacant = 'Y' THEN 'YES'
WHEN SoldAsVacant = 'S'THEN 'NO'
ELSE SoldAsVacant
END


SELECT *
FROM DataCleaning


--Delete Unwanted column 

ALTER TABLE DataCleaning
DROP COLUMN ParcelID,SaleDate,OwnerAddress

SELECT *
FROM DataCleaning