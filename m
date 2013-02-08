From: Joakim Hernberg <jbh@alchemy.lu>
Subject: 3.6.11-rt28 build failure on 32bit Intel
Date: Fri, 8 Feb 2013 19:23:28 +0100
Message-ID: <20130208192328.0fd0db59@tor.valhalla.alchemy.lu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from skinbark.wpsintrax.se ([83.145.49.220]:3078 "EHLO
	skinbark.wpsintrax.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946764Ab3BHSdX (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 8 Feb 2013 13:33:23 -0500
Received: from localhost (localhost [127.0.0.1])
	by skinbark.wpsintrax.se (Postfix) with ESMTP id B4B8977C05C
	for <linux-rt-users@vger.kernel.org>; Fri,  8 Feb 2013 19:23:30 +0100 (CET)
Received: from skinbark.wpsintrax.se ([127.0.0.1])
	by localhost (skinbark.wpsintrax.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id I1i1ZaykhZyg for <linux-rt-users@vger.kernel.org>;
	Fri,  8 Feb 2013 19:23:30 +0100 (CET)
Received: from tor.valhalla.alchemy.lu (vodsl-4655.vo.lu [80.90.56.47])
	by skinbark.wpsintrax.se (Postfix) with ESMTPA id 12D3877C00D
	for <linux-rt-users@vger.kernel.org>; Fri,  8 Feb 2013 19:23:30 +0100 (CET)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

I get the following when trying to build 3.6.11-rt28 build failure on
32bit Intel:

CC arch/x86/mm/iomap_32.o 
arch/x86/mm/iomap_32.c:57:7: error: expected identifier or '(' before
'{' token
make[2]: *** [arch/x86/mm/iomap_32.o] Error 1
make[1]: *** [arch/x86/mm] Error 2
make: *** [arch/x86] Error 2

-- 

   Joakim
