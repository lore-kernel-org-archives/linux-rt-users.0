From: Jon Masters <jonathan@jonmasters.org>
Subject: [RT] 2.6.24 - stuck in serial8250_console_write
Date: Sat, 16 Feb 2008 20:39:39 -0500
Message-ID: <1203212379.5672.9.camel@perihelion>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757231AbYBQBk3@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Yo,

Anyone seen a 2.6.24 system deadlock unable to printk because another
task is already holding the console lock?

Jon.
