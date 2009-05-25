From: Udo van den Heuvel <udovdh@xs4all.nl>
Subject: Oops issue with patch-2.6.29.4-rt15
Date: Mon, 25 May 2009 08:00:50 +0200
Message-ID: <4A1A3412.80601@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from pindarots.xs4all.nl ([80.101.128.228]:60737 "EHLO
	pindarots.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751098AbZEYHAR (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 25 May 2009 03:00:17 -0400
Received: from surfplank2.hierzo (localhost.localdomain [127.0.0.1])
	by pindarots.xs4all.nl (8.14.3/8.14.3) with ESMTP id n4P60obl010502
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-rt-users@vger.kernel.org>; Mon, 25 May 2009 08:00:50 +0200
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

I decided to try linux-rt on one of my x86_64 PC's running Fedora 10. I 
installed patch-2.6.29.4-rt15 and set up my kernel.

After rebooting into the new kernel all was fine except a few exceptions:
Programs like `top`, `w` and the Gnome system monitor got Oopsed 
whenever I tried to start them. The rest of the system was stable.
Is this normal?
If so: how am I supposed to get similar functionality?
If not: what did go wrong?
Please let me know.

Anyone?

Kind regards,
Udo
