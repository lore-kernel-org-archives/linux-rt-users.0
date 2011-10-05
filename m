From: Venkat Subbiah <venkat.subbiah@cavium.com>
Subject: rt patch set and tags on mainline repo
Date: Wed, 05 Oct 2011 11:46:39 -0700
Message-ID: <4E8CA60F.3080700@cavium.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail3.caviumnetworks.com ([12.108.191.235]:1163 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755293Ab1JESrt (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 5 Oct 2011 14:47:49 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

I am still not able to figure out which of Linus's tag in the mainline 
repo would an rt patch set apply to.

For example this patch here
http://web.archive.org/web/20110612145812/http://www.kernel.org/pub/linux/kernel/projects/rt/patch-2.6.33.9-rt31.gz 


I thought could apply to the v2.6.33 tag ( 
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux.git;a=tag;h=4ac8e07ee3f251ae32329a24e0b01a316b21ead9) 
but it doesn't apply cleanly.

Q1) Alsolooks like the https://rt.wiki.kernel.org/index.php/Main_Page is 
still not available. Is there a location where I can get the split patch 
equivalent of "patch-2.6.33.9-rt31.gz".

Q2) I am really looking to patch a 2.6.32 kernel. Are there rt patch 
sets available for this version even if they are unofficial?

Thanks,
Venkat



