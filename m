Return-Path: <linux-rt-users-owner@vger.kernel.org>
Received: from victor.provo.novell.com ([137.65.250.26]:54653 "EHLO
	victor.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750976AbXH1Rr4 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 28 Aug 2007 13:47:56 -0400
Subject: Re: XFS forgets usrquota
From: Sven-Thorsten Dietrich <sdietrich@novell.com>
In-Reply-To: <Pine.LNX.4.64.0708281717530.3018@fbirervta.pbzchgretzou.qr>
References: <Pine.LNX.4.64.0708281717530.3018@fbirervta.pbzchgretzou.qr>
Content-Type: text/plain
Date: Tue, 28 Aug 2007 08:40:41 -0700
Message-Id: <1188315641.26298.1.camel@sven.thebigcorporation.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
To: Jan Engelhardt <jengelh@computergmbh.de>
Cc: linux-rt-users@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, 2007-08-28 at 17:20 +0200, Jan Engelhardt wrote:
> Hi,
> 
> 
> I was recently testing 2.6.22.3-16.1-rt from SUSE (seems to be an 
> 2.6.22.1-rt9 as base), and I noticed that XFS does not know about the 
> 'usrquota' mount option anymore, causing all mounts to fail (since I 
> have it set on by default). Any idea what's going on?
> 
> 

You mean vs. the SUSE default Kernel?

The RT Kernel had some config options out of sync with the default 10.3
Kernel's configuration.

Should be fixed in the next update.

Sven

> 	Jan
-- 
Sven-Thorsten Dietrich
+1 (415) 694-2930

