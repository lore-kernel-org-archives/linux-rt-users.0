From: Ralf Mardorf <ralf.mardorf@alice-dsl.net>
Subject: Kenrel panic with 3.18.7-rt2 - rootfs at MMC
Date: Fri, 6 Mar 2015 17:43:36 +0100
Message-ID: <20150306174336.2eb1fea9@archlinux>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail227c50.megamailservers.eu ([91.136.10.237]:49934 "EHLO
	mail36c50.megamailservers.eu" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753500AbbCFQnl (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 6 Mar 2015 11:43:41 -0500
Received: from archlinux (e182016094.adsl.alicedsl.de [85.182.16.94])
	(authenticated bits=0)
	by mail36c50.megamailservers.eu (8.13.6/8.13.1) with ESMTP id t26GhZM7023906
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO)
	for <linux-rt-users@vger.kernel.org>; Fri, 6 Mar 2015 16:43:38 +0000
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 6 Mar 2015 13:24:41 +0100, Sebastian Andrzej Siewior wrote:
>if the system is still responsible you could "dmesg > file" and then
>that file would interresting as long as there is no systemd crap in it.

That's the problem, the system isn't responsive anymore. There also is
no file /var/log/dmesg. I can reboot and run the dmesg command, but it
only shows the messages for the last boot.
I guess I'm a power user regarding several Linux things, but I'm
completely lost regarding some issues, since several distros switched
to systemd.
