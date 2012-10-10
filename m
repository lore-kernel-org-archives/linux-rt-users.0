From: Lars Segerlund <lars.segerlund@gmail.com>
Subject: Patch to set kernel cpu affinity
Date: Wed, 10 Oct 2012 11:11:02 +0200
Message-ID: <CAF-VNaoXNHYQGXXfwVpw0xkri8t4pi9_WUxTt64J-jyVq7_R3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:50624 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751329Ab2JJJLD (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 10 Oct 2012 05:11:03 -0400
Received: by mail-ee0-f46.google.com with SMTP id b15so181055eek.19
        for <linux-rt-users@vger.kernel.org>; Wed, 10 Oct 2012 02:11:02 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

 Hi,

 I am looking for a patch I saw a while ago to bind the kernel and all
threads to a single cpu, however googling like mad I am unable to find
it.
 It was for rt-preempt, but I can't remeber where I saw it.

 Have anyone seen it or have any pointers for it ?

 / regards, Lars Segerlund.
