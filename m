From: "fla83tn" <fla83tn@libero.it>
Subject: Sporadic server implementation
Date: Fri, 22 Jun 2007 20:05:40 +0200
Message-ID: <JK1U9G$D52764843ADF4807127CBE557A79E846@libero.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "linux-rt-users" <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp-out2.libero.it ([212.52.84.42]:51045 "EHLO
	smtp-out2.libero.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754771AbXFVSFl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 22 Jun 2007 14:05:41 -0400
Received: from localhost (172.31.0.50) by smtp-out2.libero.it (7.3.120)
        id 4611FD98059E257B for linux-rt-users@vger.kernel.org; Fri, 22 Jun 2007 20:05:40 +0200
Received: from smtp-out2.libero.it ([172.31.0.38])
	by localhost (asav-out9.libero.it [192.168.32.37]) (amavisd-new, port 10024)
	with ESMTP id gzSkIfbiQsuP for <linux-rt-users@vger.kernel.org>;
	Fri, 22 Jun 2007 20:05:40 +0200 (CEST)
Received: from mailrelay07.libero.it (192.168.32.94) by smtp-out2.libero.it (7.3.120)
        id 4611FD3805B26CED for linux-rt-users@vger.kernel.org; Fri, 22 Jun 2007 20:05:40 +0200
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi to all,
I'm a Computer Science student who has patched the linux-2.6.19 for sup=
porting the POSIX Sporadic server specifications. It is not yet perfect=
 (mainly because actually it does not use hrtimers) because it was only=
 a kind of exercise but I think it can be a very good point where to st=
art. If you think this  work can be useful in the RT patch let me know =
about it and I will post the patch..

Best regards,
=46lavio Pompermaier


------------------------------------------------------
Leggi GRATIS le tue mail con il telefonino i-mode=99 di Wind
http://i-mode.wind.it/
