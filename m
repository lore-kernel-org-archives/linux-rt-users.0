Return-Path: <linux-rt-users-owner@vger.kernel.org>
Received: from sovereign.computergmbh.de ([85.214.69.204]:56549 "EHLO
	sovereign.computergmbh.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751261AbXH1PUL (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 28 Aug 2007 11:20:11 -0400
Received: from localhost (localhost [127.0.0.1])
	by sovereign.computergmbh.de (Postfix) with ESMTP id 64D631CD31500
	for <linux-rt-users@vger.kernel.org>; Tue, 28 Aug 2007 17:20:10 +0200 (CEST)
Date: Tue, 28 Aug 2007 17:20:10 +0200 (CEST)
From: Jan Engelhardt <jengelh@computergmbh.de>
Subject: XFS forgets usrquota
Message-ID: <Pine.LNX.4.64.0708281717530.3018@fbirervta.pbzchgretzou.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-rt-users-owner@vger.kernel.org
To: linux-rt-users@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,


I was recently testing 2.6.22.3-16.1-rt from SUSE (seems to be an 
2.6.22.1-rt9 as base), and I noticed that XFS does not know about the 
'usrquota' mount option anymore, causing all mounts to fail (since I 
have it set on by default). Any idea what's going on?


	Jan
-- 
