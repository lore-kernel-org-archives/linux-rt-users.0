From: Dragan Noveski <perodog@gmx.net>
Subject: Re: 2.6.23.1-rt9 (and others)
Date: Wed, 07 Nov 2007 20:40:43 +0000
Message-ID: <473222CB.2030005@gmx.net>
References: <1194413959.8827.66.camel@localhost.localdomain> <4731C90E.7030509@gmx.net> <47317A05.BA47.005A.0@novell.com> <4731D580.5000902@gmx.net> <Pine.LNX.4.58.0711071129560.8572@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:51564 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751925AbXKGToE (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 7 Nov 2007 14:44:04 -0500
In-Reply-To: <Pine.LNX.4.58.0711071129560.8572@gandalf.stny.rr.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Steven Rostedt wrote:
>
> I'd recommend doing the following:
>
>  wget -O /usr/local/bin/ketchup http://people.redhat.com/srostedt/rt/tools/ketchup-0.9.8-rt1
>
>  mkdir tmp
>  cd tmp
>  ketchup -r -G 2.6.23.1-rt7
>
> This will get you the 2.6.23.1-rt7 kernel and rename the "tmp" directory
> to linux-2.6.23.1-rt7
>
> After you compiled and install -rt7 while in the same directory you can do
>
>  ketchup -r -G 2.6.23.1-rt10
>
> and it will update that kernel tree to 2.6.23.1-rt10 and again rename that
> directory. (2.6.23.1-rt10 which BTW has the compile fix).
>
>
> -- Steve
>
>   
hallo steve, very much thanks for this nice how-to, but i already
finished with rt7,8 and 10.

i ll keep this message and try another time.

cheers,
doc
