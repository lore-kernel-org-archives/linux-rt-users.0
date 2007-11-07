From: Dragan Noveski <perodog@gmx.net>
Subject: Re: 2.6.23.1-rt9 (and others)
Date: Wed, 07 Nov 2007 18:11:51 +0000
Message-ID: <4731FFE7.9050205@gmx.net>
References: <1194413959.8827.66.camel@localhost.localdomain> <4731C90E.7030509@gmx.net> <47317A05.BA47.005A.0@novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:57843 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753969AbXKGRPQ (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 7 Nov 2007 12:15:16 -0500
In-Reply-To: <47317A05.BA47.005A.0@novell.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Gregory Haskins wrote:
>
> As far as -rt7 is concerned, that doesn't make a lot of sense since cpupri isnt introduced until -rt9.  Perhaps your tree was dirtied from a previous application of -rt9?  Let me know if that doesn't appear to be the case.
>
> Regards,
> -Greg
>
>   
you were right, it was some missmatching from my side, so rt7 build 
successfully without adding any additional patch and rt8 is bulding just 
now.

cheers,
doc
