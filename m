From: Mauricio =?utf-8?Q?A=2E_Araya_L=F3pez?= <maray@inf.utfsm.cl>
Subject: The best queue for RT_PREEMPT
Date: Fri, 4 Apr 2008 14:49:41 -0400
Message-ID: <20080404184941.GA21013@alumnos.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from alegre.inf.utfsm.cl ([204.87.169.3]:33812 "EHLO
	alegre.inf.utfsm.cl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757055AbYDDStx (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 4 Apr 2008 14:49:53 -0400
Received: from ritoque.inf.utfsm.cl (ssh2.inf.utfsm.cl [204.87.169.5])
	by alegre.inf.utfsm.cl (8.13.8/8.13.8) with ESMTP id m34Inkn3023144
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-rt-users@vger.kernel.org>; Fri, 4 Apr 2008 14:49:46 -0400
Received: from rodriguez.inf.utfsm.cl (localhost.localdomain [127.0.0.1])
	by ritoque.inf.utfsm.cl (8.14.2/8.13.8) with ESMTP id m34InjA3021405
	for <linux-rt-users@vger.kernel.org>; Fri, 4 Apr 2008 14:49:45 -0400
Received: (from maray@localhost)
	by rodriguez.inf.utfsm.cl (8.14.2/8.14.2/Submit) id m34InfmE021404
	for linux-rt-users@vger.kernel.org; Fri, 4 Apr 2008 14:49:41 -0400
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi again,

I have some experience working on RTAI, and I am trying to do
something similar to a RT_FIFO. Which is the best method to have 
a FIFO queue between a real-time process and a non real-time process.
Maybe a pipe is enough, or msgget, or directly have a shared memory space,
etc... Any comment will be very welcome!

Thanks!

-- 
Mauricio Araya L. 
ACS-UTFSM Team Leader, cel: 0-81564903
Est. Magister en Ciencias de la Informatica UTFSM, Valparaiso, Chile
counter.li.org: #249395, http://www.inf.utfsm.cl/~maray 
