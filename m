From: Dong Liu <dliu.cn@gmail.com>
Subject: more Intel i7. kvm and CPU stall
Date: Sun, 15 Jul 2012 01:02:02 -0400
Message-ID: <50024ECA.7050004@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:39686 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750708Ab2GOFCI (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 15 Jul 2012 01:02:08 -0400
Received: by wibhm11 with SMTP id hm11so1781375wib.1
        for <linux-rt-users@vger.kernel.org>; Sat, 14 Jul 2012 22:02:05 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

I have tried more configuration and patches on my i7 machine. Here is a 
summary,

plain 2.6.33.9-rt31, 3.2.18-rt29 and 3.4.3-rt11 all gave me cpu stall 
error when I started kvm guests

kernel-rt-3.2.17-rt28-fc16 with all its patches from 
http://pkgs.org/fedora-16/planet-ccrma-core-testing-x86_64/ also game me 
cpu stall errors when I ran kvm guests.

The only patches and config doesn't give me cpu stall is 3.0.30-rt50 
from http://glitesoft.cern.ch/cern/mrg/slc6X/x86_64/SRPMS/ But this 
kernel won't boot inside a kvm guest.

But the exact same 3.2.18-rt29 kernel works perfectly on a Core 2 Quad 
machine. Both as the host and kvm guest!

Thanks,

dong
