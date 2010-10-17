From: android rtlinux <android.rtlinux@gmail.com>
Subject: how to avoid zillion questions during patching
Date: Sun, 17 Oct 2010 15:36:39 -0400
Message-ID: <AANLkTinLvp9Lb690Br4wE2T0MvzarKaJ97Tmdn3-6CSO@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:47886 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932444Ab0JQTgk (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 17 Oct 2010 15:36:40 -0400
Received: by vws2 with SMTP id 2so99388vws.19
        for <linux-rt-users@vger.kernel.org>; Sun, 17 Oct 2010 12:36:40 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

I have been trying to patch kernel without ketchup. When I start to
patch using "bzcat patch_name | patch -p1" it asks me zillion
questions. Is there any way to avoid that?
I am patching a modified kernel. So, I am not sure if I can use ketchup.

Thanks
