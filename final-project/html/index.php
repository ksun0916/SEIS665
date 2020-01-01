<html>
        <body>
        <h1>Final Website by Kai Sun
        <?php
        $instance_id = file_get_contents("http://instance-data/latest/meta-data/instance-id");
        echo "Hi, I'm instance ", $instance_id, "\n";
        ?>
        </h1>
        </body>
</html>
