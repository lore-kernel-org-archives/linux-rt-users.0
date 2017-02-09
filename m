From: =?UTF-8?Q?Dominic_Sacr=c3=a9?= <dominic.sacre@gmx.de>
Subject: Changing checksums of RT patches
Date: Thu, 9 Feb 2017 10:09:16 +0100
Message-ID: <12e5d51b-8589-d9ba-90cd-d00688e8602d@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.22]:60122 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751891AbdBIJKh (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 9 Feb 2017 04:10:37 -0500
Received: from [100.84.97.19] ([109.43.1.83]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MLNeQ-1ccIi531P8-000YOj for
 <linux-rt-users@vger.kernel.org>; Thu, 09 Feb 2017 10:10:31 +0100
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

I noticed that recently the compressed RT patches (.patch.gz) at
https://www.kernel.org/pub/linux/kernel/projects/rt started changing.
The actual content of the patches seems to remain unchanged, but it
looks like the gzipped files are being regenerated, resulting in
different checksums.

This is a problem for example for OpenEmbedded-based projects, which use
MD5 and SHA256 checksums (basically hardcoded into Bitbake recipes) to
verify the integrity of files being downloaded.

Does someone know why this is happening?


Thanks,

Dominic
