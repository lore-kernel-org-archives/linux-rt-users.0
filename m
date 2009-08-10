From: Wolfgang Steinwender <wolfgang@psysteme.de>
Subject: Re: Problem with hwlat detector in smp_processor_id()
Date: Mon, 10 Aug 2009 16:07:27 +0200
Message-ID: <4A80299F.2040008@psysteme.de>
References: <4A55D53A.6040108@psysteme.de> <4A560069.6010602@osadl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Carsten Emde <Carsten.Emde@osadl.org>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:65151 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755032AbZHJOHG (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 10 Aug 2009 10:07:06 -0400
In-Reply-To: <4A560069.6010602@osadl.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Carsten Emde wrote:
> Does the attached patch help?

Sorry for the late reply. I now switched to linux-2.6.29.6-rt23
(which has the patch included) and verified that the problem is
solved. Reverting the patch gives the problem again.

Now the error messages have disappeared, but I really cannot
tell if the test is doing something at all.

Here's the output from running the python script from rt-tests-50:
$> hwlatdetect --debug
debugging prints turned on
looking for modules
module path: /lib/modules/2.6.29.6-rt23-pae-debug/kernel/drivers/misc
checking
/lib/modules/2.6.29.6-rt23-pae-debug/kernel/drivers/misc/hwlat_detector.ko
not mounting debugfs
test duration is 120s
hwlatdetect:  test duration 120 seconds
   parameters:
        Latency threshold: 10us
        Sample window:     1000000us
        Sample width:      500000us
     Non-sampling period:  500000us
        Output File:       None

Starting test
Starting hardware latency detection for 120 seconds
enabling detector module
first attempt at enable
detector module enabled
disabling detector module
first attempt at disable
detector module disabled
Hardware latency detection done (0 samples)
test finished
Max Latency: 0us
Samples recorded: 0
Samples exceeding threshold: 0
not umounting debugfs

The output from the hwlat_detector module is:
hwlat_detector: version 1.0.0

For me, the output "Samples recorded: 0" means that no samples have
been read at all. Or do I misinterpret the output?

It is also not possible for me to cat the sample entry
when the module is enabled: "strace cat sample"
just waits forever:
open("sample", O_RDONLY|O_LARGEFILE)    = 3
fstat64(3, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
read(3,

Is there anything else I can try?


Best regards,
W. Steinwender

