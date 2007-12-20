From: "Jaswinder Singh" <jaswinderlinuxrt@gmail.com>
Subject: loadavg vs loadavgrt
Date: Thu, 20 Dec 2007 16:05:05 +0530
Message-ID: <1985e0f60712200235v61e78b99s646149e0d27f125b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Ingo Molnar" <mingo@elte.hu>
To: RT <linux-rt-users@vger.kernel.org>,
	"Steven Rostedt" <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.237]:48921 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756065AbXLTKfG (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 20 Dec 2007 05:35:06 -0500
Received: by nz-out-0506.google.com with SMTP id s18so1739155nze.1
        for <linux-rt-users@vger.kernel.org>; Thu, 20 Dec 2007 02:35:05 -0800 (PST)
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

By linux-2.6.23-rt3 on ideal condition, I am getting :-

root@192.168.1.253:~# cat /proc/loadavgrt
1.00 1.00 1.00 0/52 1158
root@192.168.1.253:~# cat /proc/loadavg
0.00 0.00 0.02 1/52 1159
root@192.168.1.253:~#

I am curious:
1. Why loadavgrt is not reflecting load on loadavg

2. loadavgrt is giving correct information or it is bogus

Thank you,

Jaswinder Singh.
