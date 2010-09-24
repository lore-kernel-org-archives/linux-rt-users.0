From: Sri Ram Vemulpali <sri.ram.gmu06@gmail.com>
Subject: regarding synchronization code
Date: Fri, 24 Sep 2010 18:56:42 -0400
Message-ID: <AANLkTikhWVuL18zRcPTu2TcEQrv8Bpr4O0eafNsPgNjt@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Kernel-newbies <kernelnewbies@nl.linux.org>,
	Linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:39792 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755538Ab0IXW4r (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 24 Sep 2010 18:56:47 -0400
Received: by qyk36 with SMTP id 36so1975919qyk.19
        for <linux-rt-users@vger.kernel.org>; Fri, 24 Sep 2010 15:56:46 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi all,

  I am encountering alot macros in the code. I did not understand what
those macro means.

  Can anyone explain them and the use of them putting them like that.

   "unlikely"
   "always_inline"  -- defined at the signature of the function.
   "inline" -- I know inline keyword in compiler is used to place the
code in to the caller function at the time of compiler, but why
declared as macro

    Any help would be appreciated.

-- 
Regards,
Sri.
