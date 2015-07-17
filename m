From: =?UTF-8?B?Sm/Dq2wgS3LDpGhlbWFubg==?= <jkraehemann@gmail.com>
Subject: udelay and ndelay includes and linker
Date: Fri, 17 Jul 2015 23:15:01 +0200
Message-ID: <CA+Owze6yjuSdWZO_awTKbmP4m-iXadkABUB-z2OdvqRT1fnCHw@mail.gmail.com>
Reply-To: jkraehemann-guest@users.alioth.debian.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-yk0-f169.google.com ([209.85.160.169]:36145 "EHLO
	mail-yk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752156AbbGQVPC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 17 Jul 2015 17:15:02 -0400
Received: by ykay190 with SMTP id y190so99488281yka.3
        for <linux-rt-users@vger.kernel.org>; Fri, 17 Jul 2015 14:15:01 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi, since on my system /usr/include/linux/delay.h is missing I'm
asking me how to include it and link against it.

I'd like to use ndelay() instead of nanosleep().

Any hint would be helpful.

Thank you

cheers,
Jo=C3=ABl Kr=C3=A4hemann
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
