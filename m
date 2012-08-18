From: Mike Galbraith <efault@gmx.de>
Subject: Re: linux rt 3.4.8-rt16 and nv 302.17, and system freezes, does
 nvidia strike again?
Date: Sat, 18 Aug 2012 06:33:56 +0200
Message-ID: <1345264436.8439.15.camel@marge.simpson.net>
References: <CAOLSsAw3QG40xSokZ8spMa1_J81n2L9fb2g68jEo-r0iCMP8gA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: RT <linux-rt-users@vger.kernel.org>
To: Javier Sanz <jsanza@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.22]:54505 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750957Ab2HREd7 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 18 Aug 2012 00:33:59 -0400
In-Reply-To: <CAOLSsAw3QG40xSokZ8spMa1_J81n2L9fb2g68jEo-r0iCMP8gA@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 2012-08-17 at 22:40 +0200, Javier Sanz wrote: 
> Hello,
> 
> Sorry about nvidia drivers issue, but nobody help me from another forums ...
> 
> I can't boot linux rt 3.4.8-rt16 with nvidia 302.17 patched for 3.x-rt
> series using the famous  "patch-3.0-rt-nvidia.patch"
> 
> My Fedora 17 starts ok,  services ok, but into loading nvidia driver,
> it freezes ...  no text mode, no keyboard .. all locked !
> 
> I guess some one has it working ... can you help me? which patch did
> you use?  how do you do it?  where can i find it ?
> 
> I'll try with lastest 3.4.9-rt17  and  nvidia 304.37 with the same patch ..

I just built 3.4.9-rt17 with nvidia 304.37.  For my 8600 GT card at
least, no patch is required, it builds and runs just fine as is.

-Mike

