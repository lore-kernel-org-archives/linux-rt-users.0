From: Jens Koehler <jenskxxx@googlemail.com>
Subject: hrtimer: interrupt took 10252 ns - meaning?
Date: Wed, 1 Jun 2016 09:46:56 +0200
Message-ID: <CAL7_A_Vs5F5nJM68-TJVUZpOu7pE7=9MkSLggA2c6TML9UM-Mw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-vk0-f66.google.com ([209.85.213.66]:34153 "EHLO
	mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751037AbcFAHq5 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 1 Jun 2016 03:46:57 -0400
Received: by mail-vk0-f66.google.com with SMTP id a6so1850134vkg.1
        for <linux-rt-users@vger.kernel.org>; Wed, 01 Jun 2016 00:46:57 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

I am running a linux kernel with rt preempt patch and made also a  rt
application. Application works good but sometimes I a get a message
like "hrtimer: interrupt took 10252 ns" or "NOHZ:
local_softirq_pending 102". What does it mean and is it a problem?

Thanks and regards,
Jens
