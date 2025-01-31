Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B004A24
	for <linux-rt-users@vger.kernel.org>; Fri, 31 Jan 2025 06:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738305201; cv=none; b=ZvagLBGvlbOLhmN7u43ZH/xrFrep/wHJ/eAKoeriqyAhcvrb1ADd2n5ri/7unEYpNOaYstotZL/t1lI7fvB1OYeRGdcR5QqjUodjXfri6mvQDPWXMtNIwWjRppugORriNpMV29/LmUMVeej6gQ21ax37tTqmzzkjwyRkvpOVBAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738305201; c=relaxed/simple;
	bh=Lh3GWhaIhzZKhOtwfT8RJmGKDNXTfgzf7GoZSMDwOhc=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=tm3V2Xg94EDTN2Y7/pnztVEZ+8+RabDxt5kbZKHevk3pmd3MVHHcYEDNE35PN8eJZk6OF0RUsg/HHRY2fo0IUEaVie+OOMXO/icsaCqaBJ4iKjpRbUVml68tPAHE4OHmQtL2uxXmIm/tQehUDsnjr0W9r0c38VZ0rEHvrFKF5oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; arc=none smtp.client-ip=212.27.42.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Received: from [IPV6:2a01:e0a:244:b080:8ef8:8422:2494:f0e0] (unknown [IPv6:2a01:e0a:244:b080:8ef8:8422:2494:f0e0])
	by smtp1-g21.free.fr (Postfix) with ESMTP id AD67FB00535
	for <linux-rt-users@vger.kernel.org>; Fri, 31 Jan 2025 07:33:17 +0100 (CET)
Message-ID: <79dc829d-8a6b-4d8d-8084-8527ec438c51@free.fr>
Date: Fri, 31 Jan 2025 07:33:17 +0100
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-rt-users@vger.kernel.org
From: Yann Collette <ycollette.nospam@free.fr>
Subject: Build error with gcc 15.0 and kernel rt 5.10.233.rt125
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello,

I met a build error while building the kernel rt 5.10.233-rt125 on 
Fedora rawhide with gcc-15.0.1.
It looks like gcc-15.0.1 switched to C23.

Here is the error message:

   CC      arch/x86/realmode/rm/wakemain.o
In file included from ./include/uapi/linux/posix_types.h:5,
                  from ./include/uapi/linux/types.h:14,
                  from ./include/linux/types.h:6,
                  from arch/x86/realmode/rm/wakeup.h:11,
                  from arch/x86/realmode/rm/wakemain.c:2:
./include/linux/stddef.h:11:9: error: cannot use keyword â€˜falseâ€™ as 
enumeration constant
    11 |         false   = 0,
       |         ^~~~~
./include/linux/stddef.h:11:9: note: â€˜falseâ€™ is a keyword with 
â€˜-std=c23â€™ onwards
./include/linux/types.h:30:33: error: â€˜boolâ€™ cannot be defined via 
â€˜typedefâ€™
    30 | typedef _Bool                   bool;
       |                                 ^~~~
./include/linux/types.h:30:33: note: â€˜boolâ€™ is a keyword with 
â€˜-std=c23â€™ onwards
./include/linux/types.h:30:1: warning: useless type name in empty 
declaration
    30 | typedef _Bool                   bool;
       | ^~~~~~~
make[3]: *** [scripts/Makefile.build:286: 
arch/x86/realmode/rm/wakemain.o] Error 1
make[2]: *** [arch/x86/realmode/Makefile:23: 
arch/x86/realmode/rm/realmode.bin] Error 2
make[1]: *** [scripts/Makefile.build:503: arch/x86/realmode] Error 2
make[1]: *** Waiting for unfinished jobs....

Best regards,

Yann

