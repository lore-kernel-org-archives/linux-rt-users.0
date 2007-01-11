From: Steven Scholz <steven.scholz@imc-berlin.de>
Subject: generating 100% load for cyclictest ?
Date: Thu, 11 Jan 2007 15:56:09 +0100
Message-ID: <45A65009.8070902@imc-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.imc-berlin.de ([217.110.46.186]:4945 "EHLO
	mail.imc-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030240AbXAKO4M (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 11 Jan 2007 09:56:12 -0500
Received: from mailserver.berlin.imc-berlin.de (mailserver.berlin.imc-berlin.de [10.0.0.19])
	by mail.imc-berlin.de (Postfix) with ESMTP id 8BDDC2F02E
	for <linux-rt-users@vger.kernel.org>; Thu, 11 Jan 2007 16:50:28 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mailserver.berlin.imc-berlin.de (Postfix) with ESMTP id 9174910B6D
	for <linux-rt-users@vger.kernel.org>; Thu, 11 Jan 2007 15:56:10 +0100 (CET)
Received: from [10.0.2.10] (scholz.berlin.imc-berlin.de [10.0.2.10])
	by mailserver.berlin.imc-berlin.de (Postfix) with ESMTP id AE29CA0AD
	for <linux-rt-users@vger.kernel.org>; Thu, 11 Jan 2007 15:56:09 +0100 (CET)
To: linux-rt-users@vger.kernel.org
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi,

on http://rt.wiki.kernel.org/index.php/Cyclictest some test cases mention a
"100% load".

How is this load created? Any recommendations?

I am testing on an embedded system with a small rootfs. So I don't have a
gcc running on the target that could compile the kernel or something ...

Thanks.

-- 
Steven
