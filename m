From: "Girish kathalagiri" <girish.sk@gmail.com>
Subject: Re: BUG: scheduling while atomic: stress
Date: Mon, 30 Jul 2007 06:26:39 +0000
Message-ID: <34ac6d890707292326w1aa1c7e0p8aa7992eff9a2379@mail.gmail.com>
References: <34ac6d890707260635m1d1165d1m5e01b7faa925e86c@mail.gmail.com>
	 <34ac6d890707292237t591af349i5a0144afda98d091@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.245]:11937 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762953AbXG3G0k (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 30 Jul 2007 02:26:40 -0400
Received: by an-out-0708.google.com with SMTP id d31so261057and
        for <linux-rt-users@vger.kernel.org>; Sun, 29 Jul 2007 23:26:39 -0700 (PDT)
In-Reply-To: <34ac6d890707292237t591af349i5a0144afda98d091@mail.gmail.com>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

> ./stress --cpu 8 --io 4 --vm 2 --vm-bytes 2M --timeout 300s
> The problem seems to be caused by the vm part of the stress code.
> When I run this with vm = 1 it works fine , when the vm thread is
> increased it causes the problem.
> The thread does sync
>
> while (1){
>    sync ();
>  }
Sorry of the terrible mistake
VM thread does malloc and free.
while (1)
    {
      if (do_malloc)
        {
          dbg (stdout, "allocating %lli bytes ...\n", bytes);
          if (!(ptr = (char *) malloc (bytes * sizeof (char))))
            {
              err (stderr, "hogvm malloc failed: %s\n", strerror (errno));
              return 1;
            }
          if (keep)
            do_malloc = 0;
        }

      dbg (stdout, "touching bytes in strides of %lli bytes ...\n", stride);
      for (i = 0; i < bytes; i += stride)
        ptr[i] = 'Z';           /* Ensure that COW happens.  */

      if (hang == 0)
        {
          dbg (stdout, "sleeping forever with allocated memory\n");
          while (1)
            sleep (1024);
        }
      else if (hang > 0)
        {
          dbg (stdout, "sleeping for %llis with allocated memory\n", hang);
          sleep (hang);
        }

      if (do_malloc)
        {
          free (ptr);
          dbg (stdout, "freed %lli bytes\n", bytes);
        }
    }


--
Regards,
Giri
