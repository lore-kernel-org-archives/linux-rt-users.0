From: Dragan Noveski <perodog@gmx.net>
Subject: Re: 2.6.23.1-rt9 (and others)
Date: Wed, 07 Nov 2007 15:10:56 +0000
Message-ID: <4731D580.5000902@gmx.net>
References: <1194413959.8827.66.camel@localhost.localdomain> <4731C90E.7030509@gmx.net> <47317A05.BA47.005A.0@novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:56378 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756076AbXKGOOa (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 7 Nov 2007 09:14:30 -0500
In-Reply-To: <47317A05.BA47.005A.0@novell.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Gregory Haskins wrote:
> Doh!  Your error made me realize that I broke uniprocessor in -rt9.  Will fix right away.
>
> As far as -rt7 is concerned, that doesn't make a lot of sense since cpupri isnt introduced until -rt9.  Perhaps your tree was dirtied from a previous application of -rt9?  Let me know if that doesn't appear to be the case.
>
> Regards,
> -Greg
>
>
>   
sorry, i am not sure if i did not done some missmatch by copying the 
config file into the tree, but i am always doing 'rm -r', and unpacking 
the tree before compiling.
i tried again the rt9 (100% without missmatching) but it does not work....
i ll give a try with the rt6 now.

very much thanks for the support and cheers,
doc
