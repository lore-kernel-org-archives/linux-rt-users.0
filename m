From: Ashoka K <ashok.vinu@gmail.com>
Subject: Any issue to be considered if ethernet send buffer is modified
Date: Fri, 30 Aug 2013 13:51:14 +0530
Message-ID: <CALJd4cb9aZF=jzbYiAf518KW-hS+QR4u0JDHefmR5Q4DipOuPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: linux-newbie@vger.kernel.org,
	Linux RT Users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-qc0-f182.google.com ([209.85.216.182]:52721 "EHLO
	mail-qc0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753651Ab3H3IVP (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 30 Aug 2013 04:21:15 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

I use embedded system with 2.6.33, Preempt patch. To reduce the
latency of sending data by our application, the ethernet send buffer
is modified with setsockopt().

Before modification the send buffer size by default was shown as 16384 bytes.
But on proc system value shown is different, both default and max are same:
/proc/sys/net/core/wmem_default = 108544

Eventhough the above value is not modified, why the default is shown
as 16384 instead 108544. Did kernel change these values during sending
traffic ?

If send buffer is set by setsockopt(), is this value modified by
kernel during run time?

AK
