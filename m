From: Johan Borkhuis <j.borkhuis@dutchspace.nl>
Subject: Performance of RT-patch on PowerPC
Date: Fri, 27 Apr 2007 14:56:16 +0200
Message-ID: <4631F2F0.4010907@dutchspace.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from kirk.dutchspace.nl ([82.161.242.14]:34784 "EHLO
	kirk.dutchspace.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755779AbXD0M4T (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 27 Apr 2007 08:56:19 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hello all,

As I understood from several emails the arch/ppc branch is not supported 
by the RT-patch, and also will not because of missing functionality. My 
BSP (MVME3100, PPC 8540) is based on the ppc architecture however, but I 
do need hard realtime performance.

As far as I know there are a couple of choices I have:
- Port the BSP to the powerpc architecture branch
- Use Xenomai.

I know that Xenomai runs on the ppc-branch, so this would be my first 
choice at this moment. But I like to keep my options open, so I am also 
looking at porting the BSP.

Before I start on the port of the BSP I would like to know what the 
status of the RT-patch on PowerPC is. How good and stable does the patch 
run on PowerPC, and how good is the real time performance on the PowerPC?

Also I like to know how the RT-patch and Xenomai compare. I did see some 
measurements and discussions from a couple of years back between Ingo 
and Kristian Benoit. The RT patch and Xenomai had comparable results, 
but how is the current situation? Are the current results substantial 
better for one of these or for both, or are they still on the same level?

Kind regards,
    Johan Borkhuis
