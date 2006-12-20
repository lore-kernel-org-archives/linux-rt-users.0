From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Re: kernel-rt-15 give NETDEV WATCHDOG: eth1: transmit timed out
Date: Wed, 20 Dec 2006 10:45:59 +0100
Message-ID: <45890657.9050403@gmail.com>
References: <1166314848.11625.9.camel@monteirov>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-rt <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.190]:49930 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964967AbWLTJqD (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 20 Dec 2006 04:46:03 -0500
Received: by nf-out-0910.google.com with SMTP id o25so2601691nfa
        for <linux-rt-users@vger.kernel.org>; Wed, 20 Dec 2006 01:46:01 -0800 (PST)
To: sergio@sergiomb.no-ip.org
In-Reply-To: <1166314848.11625.9.camel@monteirov>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Sergio Monteiro Basto wrote:
> Hi, 
> kernel-rt-14 rocks but wiht kernel-rt-15 I got kernel: NETDEV WATCHDOG:
> eth1: transmit timed out, I downgrade to kernel-rt-14 and that got this
> problem anymore.
> 
> I not use my on-board via-rhine II Ethernet. 
> This tests has been made with one external Ethernet card, one Realtek
> Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)

Which driver (file) is used for this? As already mentioned 
here, I have same issue with smc91x.c on embedded ARM based 
board. Unfortunately, I get this with various -rtx and not 
only the recent ones. Maybe this isn't a 
driver/board/processor specific issue?

Dirk
