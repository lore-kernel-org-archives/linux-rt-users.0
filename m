Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C119322DFB4
	for <linux-rt-users@vger.kernel.org>; Wed, 12 Mar 2025 14:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741789398; cv=none; b=UhM9QoqUgdWvlTz3n+QNllcOgkPofcOHyP+UTAH2JoVZUSsGQe+/amHIvTjnD381OiegAfZyFUJQemjYRqCCqSSWEceycJeqQ9Sf/cnYz7tKeTNcOeiZUmWIeHa9ur4e02uEMvn/lwRyqHsQRbcKCWz2zG4Y6ejeKZXcbZyHCJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741789398; c=relaxed/simple;
	bh=hXKnoqnKcDxa183o9iV+Q/63k+HC4Lq/emDTpLpTJhY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R8FldJtb03q5bXGL2F3AE6No5+/9ZNeC9/XT6Jtn0zBlff4k4q7mXJaUdnJ55zgDGpLu8EK0KAL6VsuYlXUHxcg77cwHEGX1purNjzPNwhIj0cEdFFAtng/JNRT/wsoKOy8LoIwy6lFXGXE/S6BSIAyyxssI6pZKzX0qLvjuUKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UPIkiCwC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UPIkiCwC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741789394;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xCNmG99zFJk34pZBm6y7nr2TmyAAN4KPr/DhwB+yBno=;
	b=UPIkiCwCEgk+SwUTXKEIU1eQpVVrKnm7IjS4a2TIEGu/wY5yjBuNts0P0fkq8nGZRZBSoi
	/zLrK63n3fOMdWbUZnTt2/T6k9hygBKvYbSMxF2DocTZEI2NvH01Fe0tCj4NJh4663nE02
	pWIxUq2bpgVIKz3e7EhHeL3jAHZGXog=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-507-TorYFNzaPMeYt45dxm-ZAA-1; Wed,
 12 Mar 2025 10:23:10 -0400
X-MC-Unique: TorYFNzaPMeYt45dxm-ZAA-1
X-Mimecast-MFC-AGG-ID: TorYFNzaPMeYt45dxm-ZAA_1741789389
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2C08A1801A1A;
	Wed, 12 Mar 2025 14:23:09 +0000 (UTC)
Received: from wcosta-thinkpadt14gen4.rmtbr.csb (unknown [10.22.88.179])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id D8D8D1955BCB;
	Wed, 12 Mar 2025 14:23:04 +0000 (UTC)
Date: Wed, 12 Mar 2025 11:23:02 -0300
From: Wander Lairson Costa <wander@redhat.com>
To: "John B. Wyatt IV" <jwyatt@redhat.com>
Cc: Clark Williams <williams@redhat.com>, John Kacur <jkacur@redhat.com>, 
	Crystal Wood <crwood@redhat.com>, linux-rt-users@vger.kernel.org, 
	kernel-rts-sst <kernel-rts-sst@redhat.com>, "John B. Wyatt IV" <sageofredondo@gmail.com>
Subject: Re: [PATCH v4 1/2] tuna: extract common cpu and nics determination
 code into a utils.py file
Message-ID: <qpmot3azqw2353rdyofltcehjxmgbjtk437gjkbsp4abxpjjdb@qq7bn2qfhwmu>
References: <20250311203034.8065-1-jwyatt@redhat.com>
 <20250311203034.8065-2-jwyatt@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250311203034.8065-2-jwyatt@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Tue, Mar 11, 2025 at 04:30:18PM -0400, John B. Wyatt IV wrote:
> Extracting the code allows these previously local (global to the file)
> variables and functions to be used in other files of tuna. Reducing
> the number of globals makes the code cleaner and reduces the size of
> tuna-cmd.py.
> 
> Included a suggestion by Crystal to move a function from the latter
> patch into utils.py and make it dependant on get_nr_cpus() (v2).
> 
> Included a request by John Kacur to place the SPDX message at the top of
> the file (v4).
> 
> Suggested-by: Crystal Wood <crwood@redhat.com>
> 
> Signed-off-by: John B. Wyatt IV <jwyatt@redhat.com>
> Signed-off-by: John B. Wyatt IV <sageofredondo@gmail.com>
> ---
>  tuna-cmd.py   | 34 +++++++---------------------------
>  tuna/utils.py | 28 ++++++++++++++++++++++++++++
>  2 files changed, 35 insertions(+), 27 deletions(-)
>  create mode 100644 tuna/utils.py
> 
> diff --git a/tuna-cmd.py b/tuna-cmd.py
> index f37e286..d0323f5 100755
> --- a/tuna-cmd.py
> +++ b/tuna-cmd.py
> @@ -21,7 +21,7 @@ from functools import reduce
>  import tuna.new_eth as ethtool
>  import tuna.tuna_sched as tuna_sched
>  import procfs
> -from tuna import tuna, sysfs
> +from tuna import tuna, sysfs, utils
>  import logging
>  import time
>  import shutil
> @@ -76,7 +76,6 @@ except:
>  
>  # FIXME: ETOOMANYGLOBALS, we need a class!
>  
> -nr_cpus = None
>  ps = None
>  irqs = None
>  
> @@ -233,25 +232,6 @@ def gen_parser():
>      return parser
>  
>  
> -def get_nr_cpus():
> -    """ Get all cpus including disabled cpus """
> -    global nr_cpus
> -    if nr_cpus:
> -        return nr_cpus
> -    nr_cpus = os.sysconf('SC_NPROCESSORS_CONF')
> -    return nr_cpus
> -
> -nics = None
> -
> -
> -def get_nics():
> -    global nics
> -    if nics:
> -        return nics
> -    nics = ethtool.get_active_devices()
> -    return nics
> -
> -
>  def thread_help(tid):
>      global ps
>      if not ps:
> @@ -277,7 +257,7 @@ def save(cpu_list, thread_list, filename):
>          if (cpu_list and not set(kt.affinity).intersection(set(cpu_list))) or \
>             (thread_list and kt.pid not in thread_list):
>              del kthreads[name]
> -    tuna.generate_rtgroups(filename, kthreads, get_nr_cpus())
> +    tuna.generate_rtgroups(filename, kthreads, utils.get_nr_cpus())
>  
>  
>  def ps_show_header(has_ctxt_switch_info, cgroups=False):
> @@ -328,7 +308,7 @@ def format_affinity(affinity):
>      if len(affinity) <= 4:
>          return ",".join(str(a) for a in affinity)
>  
> -    return ",".join(str(hex(a)) for a in procfs.hexbitmask(affinity, get_nr_cpus()))
> +    return ",".join(str(hex(a)) for a in procfs.hexbitmask(affinity, utils.get_nr_cpus()))
>  
>  def ps_show_thread(pid, affect_children, ps, has_ctxt_switch_info, sock_inodes,
>                     sock_inode_re, cgroups, columns=None, compact=True):
> @@ -351,7 +331,7 @@ def ps_show_thread(pid, affect_children, ps, has_ctxt_switch_info, sock_inodes,
>                  irqs = procfs.interrupts()
>              users = irqs[tuna.irq_thread_number(cmd)]["users"]
>              for u in users:
> -                if u in get_nics():
> +                if u in utils.get_nics():
>                      users[users.index(u)] = "%s(%s)" % (
>                          u, ethtool.get_module(u))
>              users = ",".join(users)
> @@ -486,7 +466,7 @@ def do_ps(thread_list, cpu_list, irq_list, show_uthreads, show_kthreads,
>  
>  
>  def find_drivers_by_users(users):
> -    nics = get_nics()
> +    nics = utils.get_nics()
>      drivers = []
>      for u in users:
>          try:
> @@ -689,10 +669,10 @@ def main():
>          apply_config(args.profilename)
>  
>      elif args.command in ['include', 'I']:
> -        tuna.include_cpus(args.cpu_list, get_nr_cpus())
> +        tuna.include_cpus(args.cpu_list, utils.get_nr_cpus())
>  
>      elif args.command in ['isolate', 'i']:
> -        tuna.isolate_cpus(args.cpu_list, get_nr_cpus())
> +        tuna.isolate_cpus(args.cpu_list, utils.get_nr_cpus())
>  
>      elif args.command in ['run', 'r']:
>  
> diff --git a/tuna/utils.py b/tuna/utils.py
> new file mode 100644
> index 0000000..f55432d
> --- /dev/null
> +++ b/tuna/utils.py
> @@ -0,0 +1,28 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +# Copyright (C) 2024 John B. Wyatt IV
> +
> +import os
> +
> +import tuna.new_eth as ethtool
> +
> +# Collect a few globals and functions so they can be reused in other modules
> +nr_cpus = None
> +nics = None
> +
> +def get_nr_cpus():
> +    """ Get all cpus including disabled cpus """
> +    global nr_cpus
> +    if nr_cpus != None:

Really a nit: as a general standard, objects should be compared to None
using the "is" operator.

> +        return nr_cpus
> +    nr_cpus = os.sysconf('SC_NPROCESSORS_CONF')
> +    return nr_cpus
> +
> +def get_all_cpu_list():
> +    return list(range(get_nr_cpus()))
> +
> +def get_nics():
> +    global nics
> +    if nics != None:

Ditto.

> +        return nics
> +    nics = ethtool.get_active_devices()
> +    return nics
> -- 
> 2.48.1
> 

