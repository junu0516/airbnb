package team07.airbnb.search2;

import lombok.RequiredArgsConstructor;
import org.apache.tomcat.jni.Local;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;
import java.time.LocalDate;

@RestController
@RequiredArgsConstructor
public class Search2Controller {

    private final Search2Service search2Service;


    @GetMapping("/airbnb/search2")
    public void search2(@Validated @RequestBody Search2RequestDTO search2RequestDTO, BindingResult bindingResult){
        search2Service.searchRoom(search2RequestDTO);
        System.out.println("search2RequestDTO = " + search2RequestDTO);
    }

}
