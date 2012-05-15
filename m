From: Venkat Subbiah <vsubbiah@caviumnetworks.com>
Subject: Preemption test
Date: Tue, 15 May 2012 13:30:52 -0700
Message-ID: <4FB2BCFC.7040104@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail3.caviumnetworks.com ([12.108.191.235]:8074 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933285Ab2EOUax (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 15 May 2012 16:30:53 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Trying to compile Preepmtion test with instructions from 
https://rt.wiki.kernel.org/index.php/Preemption_Test and I run into the 
error below

g++ preempt-test.cc -g -lboost_thread-mt -lboost_program_options -o 
preempt-test
preempt-test.cc:57:40: error: boost/thread/detail/lock.hpp: No such file 
or directory

Is there a later version than v4 from 
ftp://ftp.novell.com/dev/ghaskins/preempt-test-latest.tar.bz2

The git link  
git://git.kernel.org/pub/scm/linux/kernel/git/ghaskins/preempt-test.git 
doesn't exist. Is there a git repo some where else.


Thanks,
Venkat
