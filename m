Return-Path: <linux-rt-users-owner@vger.kernel.org>
Received: from sovereign.computergmbh.de ([85.214.69.204]:47532 "EHLO
	sovereign.computergmbh.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751026AbXH1RuK (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 28 Aug 2007 13:50:10 -0400
Date: Tue, 28 Aug 2007 19:50:08 +0200 (CEST)
From: Jan Engelhardt <jengelh@computergmbh.de>
Subject: Re: XFS forgets usrquota
In-Reply-To: <1188315641.26298.1.camel@sven.thebigcorporation.com>
Message-ID: <Pine.LNX.4.64.0708281949130.3018@fbirervta.pbzchgretzou.qr>
References: <Pine.LNX.4.64.0708281717530.3018@fbirervta.pbzchgretzou.qr>
 <1188315641.26298.1.camel@sven.thebigcorporation.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-rt-users-owner@vger.kernel.org
To: Sven-Thorsten Dietrich <sdietrich@novell.com>
Cc: linux-rt-users@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


On Aug 28 2007 08:40, Sven-Thorsten Dietrich wrote:
>> I was recently testing 2.6.22.3-16.1-rt from SUSE (seems to be an 
>> 2.6.22.1-rt9 as base), and I noticed that XFS does not know about the 
>> 'usrquota' mount option anymore, causing all mounts to fail (since I 
>> have it set on by default). Any idea what's going on?
>
>You mean vs. the SUSE default Kernel?
>
>The RT Kernel had some config options out of sync with the default 10.3
>Kernel's configuration.

Ah now that you mention .config I see it, XFS_QUOTA=n. Thanks for the pointer
;-)
>
>Should be fixed in the next update.

I notice that there are quite a lot of unsynced options, especially in the
netfilter area. CONFIG_NF_CONNTRACK_H323 has often jumped at me, for example.


	Jan
-- 
