Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BD87C25B0E
	for <linux-rt-users@archiver.kernel.org>; Fri, 19 Aug 2022 09:24:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347815AbiHSJY5 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 19 Aug 2022 05:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347409AbiHSJY4 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 19 Aug 2022 05:24:56 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CD9CF2CAA;
        Fri, 19 Aug 2022 02:24:53 -0700 (PDT)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1660901091;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Ut5qrwlgfB/2d5Sg/0iIzqLXAm4Z8H/mjGQBCpyDogs=;
        b=VMfoFcg5+zHfbvZ9Q2AV50hVU9mERoubh/1WM4P6+844YpX+qYSKgaYMafAcMmZWgVNJqG
        RXeleRZ600OjrJBZ0fKZAhUCqFVf5IIkEwphh5yC9lzhUBNwBUrHdojL0B1mLcMLBBkarp
        LB2S0rmvJc/ChPvo4gEnxRC4/GcDCCnB6abBBPXBvowXQmYbPz58T32jFKgj5O9nPpFKRv
        /baVqL0HSyeD1wAL+xg4TzqJJxPsAfsGYi2Kr1KGEJjW2dXmGtq0+5YBApfX9wjNykeC/G
        s5YMchureR8UXZWqiuleORFXA0r3gJeR/6dKLJE0jPI3yGaINGdNDV1GIPc68g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1660901091;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Ut5qrwlgfB/2d5Sg/0iIzqLXAm4Z8H/mjGQBCpyDogs=;
        b=2xZyCL8OXR1CdeyBuDbpKYqGO+ESwIwToqeqHscLEUn4rhXgzIFbEUM1KlxYNvZAwFED2z
        /dYlt4gQ6AOoCtBg==
To:     Mark Gross <markgross@kernel.org>
Cc:     linux-rt-users@vger.kernel.org, stable-rt@vger.kernel.org,
        Salvatore Bonaccorso <carnil@debian.org>
Subject: [PATCH 0/9 v4.9-RT] Backports to fix random core
Date:   Fri, 19 Aug 2022 11:24:37 +0200
Message-Id: <20220819092446.980320-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi,

in v4.9.320 some random-core patches broke RT. This is a series of
backports to align with later RT versions and keep things working again.

Sebastian

