From: "=?iso-8859-1?q?=54=68=6f=6d=61=73=20=48=e4=62=65=72=6c=65?="
	<thomas.haeberle@vipco.de>
Subject: potential and requirements of RT-patched Linux
Date: Mon, 23 Mar 2009 17:06:35 +0100 (MET)
Message-ID: <200903231606.n2NG6Zqc001174@post.webmailer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from em-p00-ob.rzone.de ([81.169.146.225]:14593 "EHLO
	em-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753728AbZCWQhS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 23 Mar 2009 12:37:18 -0400
Received: from post.webmailer.de (bel.store [192.168.41.68])
	by snori-em-01.store (RZmta 18.28) with ESMTP id a0410al2NCDJYB
	for <linux-rt-users@vger.kernel.org>;
	Mon, 23 Mar 2009 17:25:18 +0100 (MET)
Received: (from httpd@localhost)
	by post.webmailer.de (8.13.7/8.13.6) id n2NG6Zqc001174
	for linux-rt-users@vger.kernel.org; Mon, 23 Mar 2009 17:06:35 +0100 (MET)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


Hello!

I am currently collecting information about the potential and requirements of a RT-patched Linux.
Some systems, numbers and thus perspectives are already on the RT-patch-wiki site, but I would like to know more about your recent experiences since the last contribution to the "Platforms Tested and in Use with CONFIG_PREEMPT_RT" table is about a year old.

What systems are you developing on? What about PowerPCs? What performance can I roughly expect if I take my little MPC5200 (500MHz, 64MB DRAM) and run it with a RT-patched Linux? Can I control my own laser-robot like the Trumpf guys? ;-)
No, seriously: The realtime capabilities on high-end hardware are quite impressive, but how do they change downward to smaller embedded systems? It's surely not a linear regession, is it?

Greetings,
Thomas

