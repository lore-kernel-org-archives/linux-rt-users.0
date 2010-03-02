From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH 0/2] fixes for 33-rt4 found while testing on powerpc
Date: Tue,  2 Mar 2010 16:51:56 -0500
Message-ID: <1267566718-9849-1-git-send-email-paul.gortmaker@windriver.com>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:46193 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753219Ab0CBVwM (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 2 Mar 2010 16:52:12 -0500
Received: from ALA-MAIL03.corp.ad.wrs.com (ala-mail03 [147.11.57.144])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id o22LqBPI011140
	for <linux-rt-users@vger.kernel.org>; Tue, 2 Mar 2010 13:52:11 -0800 (PST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

These two commits were originally done by Kevin to solve problems on a
2.6.31 based RT tree.  They carry forward onto 33-rt4 as-is, and I've
done a quick sanity test on an sbc8641d board (powerpc SMP dual core).

Paul.

