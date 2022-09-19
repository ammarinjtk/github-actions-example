-- CreateEnum
CREATE TYPE "Privacy" AS ENUM ('public', 'private');

-- CreateEnum
CREATE TYPE "CouponStatus" AS ENUM ('valid', 'used', 'expired');

-- CreateTable
CREATE TABLE "User" (
    "id" UUID NOT NULL,
    "authId" TEXT,
    "nickName" TEXT NOT NULL,
    "secret" TEXT NOT NULL,
    "counterId" TEXT,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "lastActive" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "insertedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "startedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "startedAt2" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "User_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Counter" (
    "id" TEXT NOT NULL,
    "privacy" "Privacy" NOT NULL DEFAULT 'public',
    "size" INTEGER NOT NULL DEFAULT 2,
    "drinkId" INTEGER,
    "secret" TEXT NOT NULL,
    "insertedAt" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "numUsers" INTEGER NOT NULL DEFAULT 1,

    CONSTRAINT "Counter_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Drink" (
    "id" SERIAL NOT NULL,
    "description" TEXT NOT NULL,
    "merchantId" INTEGER,
    "insertedAt" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Drink_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Coupon" (
    "id" UUID NOT NULL,
    "userId" UUID NOT NULL,
    "status" "CouponStatus" NOT NULL DEFAULT 'valid',
    "usedAt" TIMESTAMP(6),
    "merchantId" INTEGER,
    "insertedAt" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Coupon_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Merchant" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "insertedAt" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Merchant_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Subscription" (
    "id" SERIAL NOT NULL,
    "merchantId" INTEGER NOT NULL,
    "packageId" INTEGER NOT NULL,
    "startAt" TIMESTAMP(6) NOT NULL,
    "endAt" TIMESTAMP(6) NOT NULL,
    "insertedAt" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Subscription_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Package" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "insertedAt" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Package_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "User_counterId_idx" ON "User"("counterId");

-- CreateIndex
CREATE INDEX "User_lastActive_idx" ON "User"("lastActive");

-- CreateIndex
CREATE INDEX "User_insertedAt_idx" ON "User"("insertedAt");

-- CreateIndex
CREATE INDEX "User_updatedAt_idx" ON "User"("updatedAt");

-- CreateIndex
CREATE INDEX "Counter_numUsers_privacy_idx" ON "Counter"("numUsers", "privacy");

-- CreateIndex
CREATE INDEX "Counter_drinkId_numUsers_privacy_idx" ON "Counter"("drinkId", "numUsers", "privacy");

-- CreateIndex
CREATE INDEX "Counter_insertedAt_idx" ON "Counter"("insertedAt");

-- CreateIndex
CREATE INDEX "Counter_updatedAt_idx" ON "Counter"("updatedAt");

-- CreateIndex
CREATE INDEX "Drink_insertedAt_idx" ON "Drink"("insertedAt");

-- CreateIndex
CREATE INDEX "Drink_updatedAt_idx" ON "Drink"("updatedAt");

-- CreateIndex
CREATE INDEX "Coupon_insertedAt_idx" ON "Coupon"("insertedAt");

-- CreateIndex
CREATE INDEX "Coupon_updatedAt_idx" ON "Coupon"("updatedAt");

-- CreateIndex
CREATE INDEX "Merchant_insertedAt_idx" ON "Merchant"("insertedAt");

-- CreateIndex
CREATE INDEX "Merchant_updatedAt_idx" ON "Merchant"("updatedAt");

-- CreateIndex
CREATE INDEX "Subscription_insertedAt_idx" ON "Subscription"("insertedAt");

-- CreateIndex
CREATE INDEX "Subscription_updatedAt_idx" ON "Subscription"("updatedAt");

-- CreateIndex
CREATE INDEX "Package_insertedAt_idx" ON "Package"("insertedAt");

-- CreateIndex
CREATE INDEX "Package_updatedAt_idx" ON "Package"("updatedAt");

-- AddForeignKey
ALTER TABLE "User" ADD CONSTRAINT "User_counterId_fkey" FOREIGN KEY ("counterId") REFERENCES "Counter"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Counter" ADD CONSTRAINT "Counter_drinkId_fkey" FOREIGN KEY ("drinkId") REFERENCES "Drink"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Drink" ADD CONSTRAINT "Drink_merchantId_fkey" FOREIGN KEY ("merchantId") REFERENCES "Merchant"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Coupon" ADD CONSTRAINT "Coupon_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Coupon" ADD CONSTRAINT "Coupon_merchantId_fkey" FOREIGN KEY ("merchantId") REFERENCES "Merchant"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Subscription" ADD CONSTRAINT "Subscription_merchantId_fkey" FOREIGN KEY ("merchantId") REFERENCES "Merchant"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Subscription" ADD CONSTRAINT "Subscription_packageId_fkey" FOREIGN KEY ("packageId") REFERENCES "Package"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
