From: Joshua Kordani <jkordani@lsa2.com>
Subject: Patching kernel versions for which there is no version specific patch
 released?
Date: Tue, 16 Jan 2018 10:34:25 -0500
Message-ID: <413db8dc-b0d6-8f49-dd5f-2b842c06e05a@lsa2.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-cys01nam02on0095.outbound.protection.outlook.com ([104.47.37.95]:7555
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751101AbeAPPet (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 16 Jan 2018 10:34:49 -0500
Content-Language: en-US
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Greetings,

I am trying to patch a kernel for which there doesn't seem to be a 
specific patch set released.
For example, patch-4.9.61-rt52.patch.xz and patch-4.9.65-rt56.patch.xz 
exist, but nothing in between.  Is it safe to assume that 
patch-4.9.61-rt52.patch.xz is appropriate for all kernel versions from 
4.9.61 to 4.9.64?  Or, since the rt version jumps from 52 to 56, there 
are intermediate versions of the patchset for intermediate versions of 
the kernel that are available only in the git repo?

Looking to make the right call about how to patch what I need instead of 
just compiling and hoping.
Thanks for your help!

Joshua Kordani

